#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./make_one_sheet.sh input.md"
    exit 1
fi

INPUT="$1"
FILENAME="${INPUT%.*}"

# Temporary files
TMP_PDF="tmp_stage1.pdf"
TMP_PADDED="tmp_padded.pdf"
TMP_CSS="onesheet_styles.css"
OUTPUT="${FILENAME}-onesheet.pdf"

echo "Processing Markdown source for One-Sheet Zine..."

# 1. CLEANING & PREP (Copied from make_zines.sh logic)
awk 'NR==1 && /^---/ {found=1; next} found && /^---/ {found=0; next} !found {print}' "$INPUT" > "tmp_body.md"
sed -i '' -E 's/<\/?(div|section|table|aside|nav|header|footer)[^>]*>//g' "tmp_body.md"
sed -i '' '/{%/d' "tmp_body.md"
sed -i '' '/<figure/,/<\/figure>/d' "tmp_body.md"
sed -i '' 's/\[\[toc\]\]//g' "tmp_body.md"
sed -i '' '/<iframe/d' "tmp_body.md"
sed -i '' -E '/^[[:space:]]*[0-9]+[[:space:]]*$/d' "tmp_body.md"

# 2. Insert Cover Image
META_COVER=$(awk '/^---$/{f=!f;next} f && /featuredImage:/{print $2; exit}' "$INPUT" | tr -d '"' | tr -d "'")
META_COVER="${META_COVER#/}"

if [ -n "$META_COVER" ] && [ -f "$META_COVER" ]; then
    COVER_IMG="$META_COVER"
    echo "Found cover image: $COVER_IMG"
elif [ -f "assets/coverGerKissmeSm.png" ]; then
    COVER_IMG="assets/coverGerKissmeSm.png"
else
    COVER_IMG="coverGerKissmeSm.png"
fi
echo "![Cover]($COVER_IMG)" > "tmp_clean.md"
echo "" >> "tmp_clean.md"
cat "tmp_body.md" >> "tmp_clean.md"
rm "tmp_body.md"

# 3. CSS for A8 Pages (A4 / 16)
# A4 is 210mm x 297mm.
# 4 cols x 4 rows
# Width = 297mm / 4 = 74.25mm
# Height = 210mm / 4 = 52.5mm
# We set size slightly smaller for margins
cat <<EOF > "$TMP_CSS"
@page {
    size: 74mm 52mm;
    margin: 6mm;
    @bottom-center { content: counter(page); font-size: 6pt; }
}
img {
    width: 100%;
    height: auto;
    display: block;
    margin: 0;
    page-break-after: always;
}
body { font-family: sans-serif; font-size: 7pt; line-height: 1.25; }
p, ul, ol, li { 
    text-align: left; 
    margin-bottom: 0 !important;
    margin-top: 0 !important;
    padding: 0;
    orphans: 2;
    widows: 2;
    text-indent: 1em;
}
h1 { font-size: 10pt; text-align: center; page-break-before: always; border: none; padding-top: 5px; }
h2 { font-size: 8pt; text-align: center; margin-top: 0.5em; }
EOF

# 4. Generate Initial PDF
pandoc "tmp_clean.md" -o "$TMP_PDF" --pdf-engine=weasyprint --css="$TMP_CSS"

# 5. Pad to multiple of 16
PAGE_COUNT=$(pdfcpu info "$TMP_PDF" | grep "Page count" | awk '{print $NF}')
MODULO=$((PAGE_COUNT % 16))
if [ $MODULO -ne 0 ]; then
    PADDING=$((16 - MODULO))
    echo "Detected $PAGE_COUNT pages. Padding with $PADDING empty pages to reach multiple of 16..."
    for ((i=0; i<PADDING; i++)); do
        echo '<div style="page-break-before: always;">&nbsp;</div>' >> "tmp_clean.md"
    done
    pandoc "tmp_clean.md" -o "$TMP_PADDED" --pdf-engine=weasyprint --css="$TMP_CSS"
    TARGET_FILE="$TMP_PADDED"
else
    TARGET_FILE="$TMP_PDF"
fi
rm "tmp_clean.md"

# --- IMPOSITION ---
echo "Generating One-Sheet 16-Page Imposition..."

SPLIT_DIR="tmp_split_onesheet"
mkdir -p "$SPLIT_DIR"
rm -f "$SPLIT_DIR"/*

cp "$TARGET_FILE" "tmp_padded_split.pdf"
pdfcpu split "tmp_padded_split.pdf" "$SPLIT_DIR" > /dev/null

# Re-read page count
TOTAL_PAGES=$(pdfcpu info "tmp_padded_split.pdf" | grep "Page count" | awk '{print $NF}')
SHEETS=$((TOTAL_PAGES / 16))

FINAL_PAGES=""

get_page() {
    echo "$SPLIT_DIR/tmp_padded_split_$1.pdf"
}

for ((s=0; s<SHEETS; s++)); do
    OFFSET=$((s * 16))
    
    # 16-Panel Layout (4x4)
    # Row 1 (Upright): 1, 2, 3, 4
    # Row 2 (Rotated): 8, 7, 6, 5
    # Row 3 (Upright): 9, 10, 11, 12
    # Row 4 (Rotated): 16, 15, 14, 13
    
    # Indices (1-based)
    p1=$((OFFSET + 1));   p2=$((OFFSET + 2));   p3=$((OFFSET + 3));   p4=$((OFFSET + 4))
    p5=$((OFFSET + 5));   p6=$((OFFSET + 6));   p7=$((OFFSET + 7));   p8=$((OFFSET + 8))
    p9=$((OFFSET + 9));   p10=$((OFFSET + 10)); p11=$((OFFSET + 11)); p12=$((OFFSET + 12))
    p13=$((OFFSET + 13)); p14=$((OFFSET + 14)); p15=$((OFFSET + 15)); p16=$((OFFSET + 16))
    
    # Rotate Row 2 (5-8) & Row 4 (13-16)
    for p in $p5 $p6 $p7 $p8 $p13 $p14 $p15 $p16; do
        f=$(get_page $p)
        f_rot="${f%.*}_rot.pdf"
        pdfcpu rotate "$f" 180 "$f_rot" > /dev/null 2>&1
    done
    
    # Helper to get Rotated or Normal
    gr() { echo "$(get_page $1 | sed 's/.pdf/_rot.pdf/')"; }
    gn() { echo "$(get_page $1)"; }
    
    SHEET_SRC="tmp_sheet_${s}_src.pdf"
    
    pdfcpu merge "$SHEET_SRC" \
        "$(gn $p1)"  "$(gn $p2)"  "$(gn $p3)"  "$(gn $p4)" \
        "$(gr $p8)"  "$(gr $p7)"  "$(gr $p6)"  "$(gr $p5)" \
        "$(gn $p9)"  "$(gn $p10)" "$(gn $p11)" "$(gn $p12)" \
        "$(gr $p16)" "$(gr $p15)" "$(gr $p14)" "$(gr $p13)" \
        > /dev/null
    
    # Nup 16 pages -> 4x4 Grid on A4L
    SHEET_OUT="tmp_sheet_${s}_out.pdf"
    pdfcpu nup --unit mm "formsize:A4L, margin:0" "$SHEET_OUT" 16 "$SHEET_SRC" > /dev/null
    
    FINAL_PAGES="$FINAL_PAGES $SHEET_OUT"
done

# If multiple sheets, merge them? (User asked for one-sheet zine, so usually just one result)
# But if text is long, we produce multiple A4 sheets.
pdfcpu merge "$OUTPUT" $FINAL_PAGES > /dev/null

# Cleanup
rm -f "$TMP_PDF" "$TMP_PADDED" "$TMP_CSS" "tmp_padded_split.pdf" tmp_sheet_* 
rm -rf "$SPLIT_DIR"

echo "------------------------------------------------"
echo "Success! Output: $OUTPUT"
echo "PRINTING INSTRUCTIONS:"
echo "1. Paper: A4 Landscape (Single Sheet)"
echo "2. Scale: Actual Size / 100%"
echo "3. Single Sided Printing"
echo "------------------------------------------------"
