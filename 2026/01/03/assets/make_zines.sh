#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./makezine.sh input.epub"
    exit 1
fi

INPUT="$1"
EXTENSION="${INPUT##*.}"
FILENAME="${INPUT%.*}"

# Temporary files
TMP_PDF="tmp_stage1.pdf"
TMP_PADDED="tmp_padded.pdf"
TMP_CSS="zine_styles.css"
CLEAN_INPUT="tmp_clean_content.html"
OUTPUT="${FILENAME}-zine.pdf"

# --- STEP 1: CONVERT & DEEP CLEANING ---
# --- STEP 1: CONVERT & DEEP CLEANING ---
if [ "$EXTENSION" == "md" ]; then
    echo "Processing Markdown source..."
    
    # Remove Frontmatter using awk (safer for macOS)
    awk 'NR==1 && /^---/ {found=1; next} found && /^---/ {found=0; next} !found {print}' "$INPUT" > "tmp_body.md"
    
    # Remove specific container tags but keep content
    sed -i '' -E 's/<\/?(div|section|table|aside|nav|header|footer)[^>]*>//g' "tmp_body.md"
    
    # Remove Liquid Tags and HTML artifacts (Delete whole lines)
    sed -i '' '/{%/d' "tmp_body.md"
    sed -i '' '/<figure/,/<\/figure>/d' "tmp_body.md"
    sed -i '' 's/\[\[toc\]\]//g' "tmp_body.md"
    sed -i '' '/<iframe/d' "tmp_body.md"
    
    # Remove standalone numbers (Ghost page numbers from ePub)
    # Matches lines that are just numbers, possibly with whitespace
    sed -i '' -E '/^[[:space:]]*[0-9]+[[:space:]]*$/d' "tmp_body.md"
    
    # 2. Insert Cover Image (Force it as first page)
    # Attempt to read featuredImage from Frontmatter
    META_COVER=$(awk '/^---$/{f=!f;next} f && /featuredImage:/{print $2; exit}' "$INPUT" | tr -d '"' | tr -d "'")
    # Remove leading slash (e.g. /assets/... -> assets/...)
    META_COVER="${META_COVER#/}"

    if [ -n "$META_COVER" ] && [ -f "$META_COVER" ]; then
        COVER_IMG="$META_COVER"
        echo "Found cover image in metadata: $COVER_IMG"
    elif [ -f "assets/coverGerKissmeSm.png" ]; then
        COVER_IMG="assets/coverGerKissmeSm.png"
    else
        COVER_IMG="coverGerKissmeSm.png"
    fi
    echo "![Cover]($COVER_IMG)" > "tmp_clean.md"
    echo "" >> "tmp_clean.md"
    cat "tmp_body.md" >> "tmp_clean.md"
    
    rm "tmp_body.md"
    
    # 3. Zine CSS
    cat <<EOF > "$TMP_CSS"
@page {
    size: A5;
    margin: 15mm;
    @bottom-center { content: counter(page); font-size: 10pt; }
}
/* Large gutter for the fold */
@page :left { margin-right: 25mm; margin-left: 15mm; }
@page :right { margin-left: 25mm; margin-right: 15mm; }

/* Cover Image Logic */
img[src*="cover"], img[alt="Cover"] {
    width: 100%;
    height: 100%;
    object-fit: contain;
    display: block;
    margin: 0;
    page-break-after: always;
}

body { font-family: serif; }
p, ul, ol, li { 
    text-align: justify; 
    line-height: 1.6; 
    font-size: 11pt; 
    text-indent: 1.5em; 
    margin-bottom: 0 !important;
    margin-top: 0 !important;
    padding: 0;
    orphans: 2;
    widows: 2;
}
h1 { text-align: center; page-break-before: always; border: none; padding-top: 20px; break-after: avoid; }
h2, h3 { text-align: center; border: none; padding-top: 20px; break-after: avoid; margin-top: 2em; }
blockquote { font-style: italic; margin-left: 1em; }
EOF

    # 4. Generate Initial PDF to check page count
    pandoc "tmp_clean.md" -o "$TMP_PDF" --pdf-engine=weasyprint --css="$TMP_CSS"
    
    PROCESSING_FILE="$TMP_PDF"

    # --- STEP 2: PAD TO MULTIPLE OF 4 (Markdown Injection) ---
    PAGE_COUNT=$(pdfcpu info "$PROCESSING_FILE" | grep "Page count" | awk '{print $NF}')
    MODULO=$((PAGE_COUNT % 4))
    PADDING=0
    
    if [ $MODULO -ne 0 ]; then
        PADDING=$((4 - MODULO))
        echo "Detected $PAGE_COUNT pages. Padding with $PADDING empty pages to match booklet structure..."
        
        # Append empty pages to the markdown source
        for ((i=0; i<PADDING; i++)); do
            echo '<div style="page-break-before: always;">&nbsp;</div>' >> "tmp_clean.md"
        done
        
        # Re-generate PDF with padding included
        pandoc "tmp_clean.md" -o "$TMP_PADDED" --pdf-engine=weasyprint --css="$TMP_CSS"
        TARGET_FILE="$TMP_PADDED"
        
        # Update PAGE_COUNT for the imposition math
        PAGE_COUNT=$((PAGE_COUNT + PADDING))
    else
        TARGET_FILE="$PROCESSING_FILE"
    fi
    # Clean up temp md
    rm "tmp_clean.md"

elif [ "$EXTENSION" == "epub" ]; then
    echo "Scrubbing TOC and ghost formatting..."
    # ... (Keep existing EPUB logic if user reverts, or just legacy support) ...
    # For now, I'll just keep the existing block logic but simplified or just reference the previous state if I wanted to keep it.
    # But since I am replacing the block, I will just paste the previous EPUB logic here briefly or just fail if it's EPUB?
    # User specifically asked to move to MD. I will keep EPUB support minimal or copy the previous logic.
    
    # 1. Convert to HTML
    pandoc "$INPUT" -t html -o "$CLEAN_INPUT"
    sed -i '' -E '/<nav id="toc"/,/<\/nav>/d' "$CLEAN_INPUT"
    sed -i '' -E '/<section class="toc"/,/<\/section>/d' "$CLEAN_INPUT"
    sed -i '' -E 's/>[[:space:]]*([1-9]|[1-5][0-9]|60)[[:space:]]*</></g' "$CLEAN_INPUT"
    sed -i '' -E 's/<\/?(table|tbody|tr|td|div|section|aside|header|footer)[^>]*>//g' "$CLEAN_INPUT"
    
    # Re-use the CSS generation from above? Or duplicate? 
    # To save space, let's just use the CSS file generated above? No, the variable is local.
    # I will just re-output the CSS for safety.
    cat <<EOF > "$TMP_CSS"
@page {
    size: A5;
    margin: 15mm;
    @bottom-center { content: counter(page); font-size: 10pt; }
}
@page :left { margin-right: 25mm; margin-left: 15mm; }
@page :right { margin-left: 25mm; margin-right: 15mm; }
img:first-of-type {
    width: 100%;
    height: auto;
    display: block;
    margin: 0;
    page-break-after: always;
}
body { font-family: serif; }
p { 
    text-align: justify; 
    line-height: 1.6; 
    font-size: 11pt; 
    text-indent: 1.5em; 
    margin-bottom: 1.2em; 
}
h1, h2 { text-align: center; page-break-before: always; border: none; padding-top: 20px; }
EOF
    pandoc "$CLEAN_INPUT" -o "$TMP_PDF" --pdf-engine=weasyprint --css="$TMP_CSS"
    PROCESSING_FILE="$TMP_PDF"

    # --- STEP 2: PAD TO MULTIPLE OF 4 ---
    PAGE_COUNT=$(pdfcpu info "$PROCESSING_FILE" | grep "Page count" | awk '{print $NF}')
    MODULO=$((PAGE_COUNT % 4))
    if [ $MODULO -ne 0 ]; then
        PADDING=$((4 - MODULO))
        echo "Padding with $PADDING blank pages..."
        echo " " | pandoc -o blank.pdf --pdf-engine=weasyprint -V papersize=a5
        FILES_TO_MERGE="$PROCESSING_FILE"
        for ((i=0; i<PADDING; i++)); do FILES_TO_MERGE="$FILES_TO_MERGE blank.pdf"; done
        pdfcpu merge "$TMP_PADDED" $FILES_TO_MERGE
        TARGET_FILE="$TMP_PADDED"
        rm blank.pdf
    else
        TARGET_FILE="$PROCESSING_FILE"
    fi

else
    PROCESSING_FILE="$INPUT"
    # If not MD or EPUB, we assume it's already a PDF and doesn't need padding or special processing.
    # So TARGET_FILE is just the input.
    TARGET_FILE="$INPUT"
fi

# --- STEP 3: IMPOSITION (A5 -> A4 Booklet) ---
# --- STEP 3: MANUAL IMPOSITION (Split -> Reorder -> Nup) ---
echo "Generating A4 Booklet Imposition (Manual / Long-Edge Optimized)..."

# 1. Split pages to temp dir
SPLIT_DIR="tmp_split_pages"
mkdir -p "$SPLIT_DIR"
rm -f "$SPLIT_DIR"/*
cp "$TARGET_FILE" "tmp_padded_for_split.pdf"
pdfcpu split "tmp_padded_for_split.pdf" "$SPLIT_DIR" > /dev/null

# 2. Calculate Page Order
# Sequence: [N, 1, 2, N-1, N-2, 3, 4, N-3, ...]
PAGE_COUNT=$(pdfcpu info "tmp_padded_for_split.pdf" | grep "Page count" | awk '{print $NF}')
TOTAL_PAGES="$PAGE_COUNT"
SHEETS=$((TOTAL_PAGES / 4))

REORDER_LIST=""

# Function to get filename for page number
get_page_file() {
    local p=$1
    echo "$SPLIT_DIR/tmp_padded_for_split_$p.pdf"
}

for ((i=1; i<=SHEETS; i++)); do
    # Front Sheet: Left=N-2(i-1), Right=2i-1
    # Back Sheet:  Left=N-2(i-1)-1, Right=2i
    
    # Indices calculation
    p1=$((TOTAL_PAGES - 2 * (i - 1)))
    p2=$((2 * i - 1))
    p3=$((2 * i))
    p4=$((TOTAL_PAGES - 2 * (i - 1) - 1))
    
    f3=$(get_page_file $p3)
    f4=$(get_page_file $p4)

    # ROTATION for LONG EDGE FLIP
    # Rotate back-side pages (p3, p4) 180 degrees.
    # User requested: "Page 2 on Left, Page 7 on Right" (Standard Order).
    # Correct Syntax: pdfcpu rotate [flags] inFile rotation [outFile]
    
    f3_rot="${f3%.*}_rot.pdf"
    f4_rot="${f4%.*}_rot.pdf"
    
    pdfcpu rotate "$f3" 180 "$f3_rot" > /dev/null 2>&1
    pdfcpu rotate "$f4" 180 "$f4_rot" > /dev/null 2>&1
    
    # Order: FrontLeft(p1) FrontRight(p2) BackLeft(p4_rotated) BackRight(p3_rotated)
    REORDER_LIST="$REORDER_LIST $(get_page_file $p1) $(get_page_file $p2) $f4_rot $f3_rot"
done

# 3. Merge in correct order
TMP_REORDERED="tmp_reordered.pdf"
pdfcpu merge "$TMP_REORDERED" $REORDER_LIST > /dev/null

# 4. Nup (2 pages per sheet, side by side)
pdfcpu nup --unit mm "formsize:A4L, margin:0" "$OUTPUT" 2 "$TMP_REORDERED" > /dev/null || exit 1

# --- STEP 4: CLEANUP ---
rm -f "$TMP_PDF" "$TMP_PADDED" "$TMP_CSS" "$CLEAN_INPUT" "blank.pdf" "tmp_padded_for_split.pdf" "$TMP_REORDERED"
rm -rf "$SPLIT_DIR"

echo "------------------------------------------------"
echo "Success! Output: $OUTPUT"
echo "PRINTING INSTRUCTIONS:"
echo "1. Select 'Actual Size'."
echo "2. Select 'Print on both sides' (Duplex)."
echo "3. SELECT 'FLIP ON LONG EDGE' (Standard Booklet)."
echo "------------------------------------------------"