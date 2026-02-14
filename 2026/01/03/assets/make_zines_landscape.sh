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
if [ "$EXTENSION" == "epub" ]; then
    echo "Scrubbing TOC and ghost formatting..."
    
    # 1. Convert to HTML
    pandoc "$INPUT" -t html -o "$CLEAN_INPUT"
    
    # 2. REMOVE TOC: Deletes the Nav/TOC sections often found at the start
    # This addresses the issue where the TOC currently occupies Page 1 
    sed -i '' -E '/<nav id="toc"/,/<\/nav>/d' "$CLEAN_INPUT"
    sed -i '' -E '/<section class="toc"/,/<\/section>/d' "$CLEAN_INPUT"
    
    # 3. STRIP GHOST NUMBERS: Removes standalone numbers 1-60 [cite: 122, 153, 186]
    sed -i '' -E 's/>[[:space:]]*([1-9]|[1-5][0-9]|60)[[:space:]]*</></g' "$CLEAN_INPUT"
    
    # 4. FIX SPLIT-PAGES: Force single column by stripping all layout containers [cite: 159-172, 552-566]
    sed -i '' -E 's/<\/?(table|tbody|tr|td|div|section|aside|header|footer)[^>]*>//g' "$CLEAN_INPUT"
    
    # 5. Zine CSS: Ensure the Cover Image is Full Page
    cat <<EOF > "$TMP_CSS"
@page {
    size: A5;
    margin: 15mm;
    @bottom-center { content: counter(page); font-size: 10pt; }
}
/* Large gutter for the fold  */
@page :left { margin-right: 25mm; margin-left: 10mm; }
@page :right { margin-left: 25mm; margin-right: 10mm; }

/* Target the first image (Cover) to fill the page  */
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

    # Generate the Reader-Order A5 PDF
    pandoc "$CLEAN_INPUT" -o "$TMP_PDF" --pdf-engine=weasyprint --css="$TMP_CSS"
    PROCESSING_FILE="$TMP_PDF"
else
    PROCESSING_FILE="$INPUT"
fi

# --- STEP 2: PAD TO MULTIPLE OF 4 ---
PAGE_COUNT=$(pdfcpu info "$PROCESSING_FILE" | grep "Page count" | awk '{print $NF}')
MODULO=$((PAGE_COUNT % 4))
if [ $MODULO -ne 0 ]; then
    PADDING=$((4 - MODULO))
    echo " " | pandoc -o blank.pdf --pdf-engine=weasyprint -V papersize=a5
    FILES_TO_MERGE="$PROCESSING_FILE"
    for ((i=0; i<PADDING; i++)); do FILES_TO_MERGE="$FILES_TO_MERGE blank.pdf"; done
    pdfcpu merge "$TMP_PADDED" $FILES_TO_MERGE
    TARGET_FILE="$TMP_PADDED"
    rm blank.pdf
else
    TARGET_FILE="$PROCESSING_FILE"
fi

# --- STEP 3: IMPOSITION (A5 -> A4 Booklet) ---
echo "Generating A4 Booklet Imposition..."
# 'binding:long' ensures all pages stay upright in the PDF 
pdfcpu booklet --unit mm "formsize:A4L, margin:0, btype:booklet, binding:long" "$OUTPUT" 2 "$TARGET_FILE" || exit 1

# --- STEP 4: CLEANUP ---
rm -f "$TMP_PDF" "$TMP_PADDED" "$TMP_CSS" "$CLEAN_INPUT"

echo "------------------------------------------------"
echo "Success! Output: $OUTPUT"
echo "PRINTING INSTRUCTIONS:"
echo "1. Select 'Actual Size'."
echo "2. Select 'Print on both sides' (Duplex)."
echo "3. SELECT 'FLIP ON LONG EDGE'."
echo "------------------------------------------------"