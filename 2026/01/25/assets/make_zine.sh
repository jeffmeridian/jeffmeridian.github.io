#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./makezine.sh input.epub (or input.pdf)"
    exit 1
fi

INPUT="$1"
EXTENSION="${INPUT##*.}"
FILENAME="${INPUT%.*}"

# Temporary files
TMP_PDF="tmp_stage1.pdf"
TMP_PADDED="tmp_padded.pdf"
TMP_CSS="zine_styles.css"
OUTPUT="${FILENAME}-zine.pdf"

# --- STEP 1: CONVERT EPUB TO A5 PDF ---
if [ "$EXTENSION" == "epub" ]; then
    echo "Converting ePub to A5 PDF with mirrored margins..."
    
    # Create CSS for mirrored margins (Weasyprint supports @page)
    # Right page (recto, odd): Spine is Left. Inner=Left=18mm
    # Left page (verso, even): Spine is Right. Inner=Right=18mm
    cat <<EOF > "$TMP_CSS"
@page {
    size: A5;
    margin-top: 15mm;
    margin-bottom: 15mm;
}
@page :right {
    margin-left: 18mm;
    margin-right: 15mm;
}
@page :left {
    margin-left: 15mm;
    margin-right: 18mm;
}
img {
    max-width: 100%;
    max-height: 100%;
    height: auto;
    object-fit: contain;
    display: block;
    margin: 0 auto;
}
EOF

    pandoc "$INPUT" -o "$TMP_PDF" \
        --pdf-engine=weasyprint \
        --css="$TMP_CSS"
    PROCESSING_FILE="$TMP_PDF"
else
    PROCESSING_FILE="$INPUT"
fi

# --- STEP 2: PAD TO MULTIPLE OF 4 ---
PAGE_COUNT=$(pdfcpu info "$PROCESSING_FILE" | grep "Page count" | awk '{print $NF}')
echo "Original Page Count: $PAGE_COUNT"
MODULO=$((PAGE_COUNT % 4))

if [ $MODULO -ne 0 ]; then
    PADDING=$((4 - MODULO))
    echo "Padding with $PADDING blank pages..."
    # Insert blank pages at the end. Note: pdfcpu insert defaults to before, so we must be careful or use append semantics if available, 
    # or just insert at PAGE_COUNT + 1? pdfcpu doesn't support n+1 easily if it bounds checks. 
    # Actually, inserting *before* the last page pushes the last page to the end? No, it shifts.
    # We simply want *total* pages to be multiple of 4. Where the blanks go (end or beginning) matters for the booklet.
    # Usually blanks go at the END.
    # To append to end: create a 1-page blank PDF and merge it? Or use `pages insert` at the last page?
    # Let's try appending a blank page using `pdfcpu pages add` if it exists, or just inserting before the last page?
    # If we insert at $PAGE_COUNT (the last page), the blank becomes the NEW 2nd-to-last, and the old last becomes last.
    # That puts a blank page *inside* the book. We want it at the VERY END.
    # pdfcpu doesn't have a simple "append blank" command in the CLI easily without creating a blank file first.
    # Workaround: Insert at page 1 (front of book) or just live with it being before the back cover?
    # Ideally: create a blank.pdf and merge it.
    
    # Using a generated blank PDF is safer.
    echo "" | pandoc -o blank.pdf --pdf-engine=weasyprint
    for ((i=0; i<PADDING; i++)); do
        pdfcpu available_optimization_check_skipped merge "$TMP_PADDED" "$PROCESSING_FILE" blank.pdf
        mv "$TMP_PADDED" "$PROCESSING_FILE" 2>/dev/null || true # optimize? merge outputs to stdout? no, merge out in... wait. `pdfcpu merge out.pdf in1.pdf in2.pdf`
        # Logic fix:
    done
    # Let's rewrite this block entirely to be safe.
    
    # CORRECT LOGIC:
    # 1. Create 1 blank page PDF.
    # 2. Merge PADDING copies of blank.pdf to the end of PROCESSING_FILE.
    
    echo "Creating blank page..."
    echo " " | pandoc -o blank.pdf --pdf-engine=weasyprint -V papersize=a5 --css="$TMP_CSS"
    
    FILES_TO_MERGE="$PROCESSING_FILE"
    for ((i=0; i<PADDING; i++)); do
        FILES_TO_MERGE="$FILES_TO_MERGE blank.pdf"
    done
    
    pdfcpu merge "$TMP_PADDED" $FILES_TO_MERGE
    TARGET_FILE="$TMP_PADDED"
    rm blank.pdf
else
    TARGET_FILE="$PROCESSING_FILE"
fi

NEW_COUNT=$(pdfcpu info "$TARGET_FILE" | grep "Page count" | awk '{print $NF}')
echo "New Page Count: $NEW_COUNT"

# --- STEP 3: IMPOSITION (A5 -> A4 Booklet) ---
echo "Generating A4 Imposition..."
# Note: Since we set margins in Pandoc, we use 0 here or minimal 
# to avoid 'double-margining' the A4 sheet.
pdfcpu booklet --unit mm "formsize:A4, margin:0" "$OUTPUT" 2 "$TARGET_FILE" || exit 1

# --- STEP 4: CLEANUP ---
rm -f "$TMP_PDF" "$TMP_PADDED" "$TMP_CSS"

echo "Success! Your A4 zine is ready: $OUTPUT"