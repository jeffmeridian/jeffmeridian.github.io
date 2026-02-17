#!/bin/bash

# 1. Validation
if [ -z "$1" ]; then
    echo "Usage: ./create_epub.sh <source_file.md> [target_directory]"
    exit 1
fi

SOURCE_FILE="$1"
SOURCE_DIR=$(dirname "$SOURCE_FILE")
FILENAME=$(basename -- "$SOURCE_FILE")
BASENAME="${FILENAME%.*}"
TARGET_DIR="${2:-.}"
TEMP_FILE="${SOURCE_DIR}/temp_clean_content.md"
STYLE_FILE="${SOURCE_DIR}/epub_style.css"

mkdir -p "$TARGET_DIR"
OUTPUT_FILE="$TARGET_DIR/$BASENAME.epub"

# 2. Metadata Extraction
TITLE=$(grep -m 1 "^title:" "$SOURCE_FILE" | sed -E 's/title:[[:space:]]*//' | tr -d "'\"")
AUTHOR=$(grep -A 1 "authors:" "$SOURCE_FILE" | grep "name:" | head -n 1 | sed -E 's/.*name:[[:space:]]*//' | tr -d "'\"")
YEAR=$(grep -m 1 "date:" "$SOURCE_FILE" | sed -E 's/.*date:[[:space:]]*([0-9]{4}).*/\1/')

# Extract Cover Image Path
RELATIVE_COVER_PATH=$(grep "featuredImage:" "$SOURCE_FILE" | sed -E 's/.*featuredImage:[[:space:]]*//' | tr -d '"' | tr -d "'")
CLEAN_PATH=$(echo "$RELATIVE_COVER_PATH" | sed 's|^/||')
FULL_COVER_PATH="$SOURCE_DIR/$CLEAN_PATH"

# 3. Create Novel-Style CSS
cat <<EOF > "$STYLE_FILE"
p {
    margin-top: 0;
    margin-bottom: 0;
    text-indent: 1.5em;
    text-align: justify;
}
h1 + p, h2 + p, h3 + p, .copyright-page p {
    text-indent: 0;
}
.copyright-page {
    text-align: center;
    font-size: 0.9em;
    margin-top: 10em;
}
h2 {
    margin-top: 2em;
    text-align: center;
    text-transform: uppercase;
}
EOF

# 4. Clean Content and Inject Copyright Page
echo "Cleaning content and adding Copyright page..."

# First, capture the YAML frontmatter (lines between the first two ---)
sed -n '1,/---/p' "$SOURCE_FILE" > "$TEMP_FILE"

# Second, add the Copyright Page content
cat <<EOF >> "$TEMP_FILE"

## Copyright

<section class="copyright-page">
<p><strong>$TITLE</strong></p>
<p>© $YEAR $AUTHOR</p>
<p>All rights reserved.</p>
<p>https://jeffmeridian.pages.dev/</p>
</section>

EOF

# Third, append the rest of the cleaned content (skipping the original frontmatter)
sed -E '1,/---/d; /\{%.*%\}|\{\{.*\}\}|<[/]?figure.*>|<[/]?figcaption.*>|<[/]?div.*>|\[\[[tT][oO][cC]\]\]/d' "$SOURCE_FILE" | \
sed -E 's/^(## )/\n\1/' >> "$TEMP_FILE"

# 5. Execute Pandoc
PANDOC_ARGS=(
    "$TEMP_FILE"
    -f markdown
    -o "$OUTPUT_FILE"
    --toc
    --toc-depth=2
    --epub-chapter-level=2
    --css="$STYLE_FILE"
    -s
)

if [ -n "$CLEAN_PATH" ] && [ -f "$FULL_COVER_PATH" ]; then
    echo "✅ Cover image found: $FULL_COVER_PATH"
    pandoc "${PANDOC_ARGS[@]}" --epub-cover-image="$FULL_COVER_PATH"
else
    echo "⚠️  No cover image. Generating without."
    pandoc "${PANDOC_ARGS[@]}"
fi

# 6. Cleanup
rm "$TEMP_FILE"
rm "$STYLE_FILE"

echo "-----------------------------------"
echo "Success! Ebook with Copyright Page: $OUTPUT_FILE"