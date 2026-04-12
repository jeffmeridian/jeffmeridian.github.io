import os
import sys
import glob

# Ensure PyMuPDF is installed
try:
    import fitz
except ImportError:
    print("PyMuPDF not installed. Please run: pip install PyMuPDF")
    sys.exit(1)

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 update_pdf.py <source_pdf> <language_code>")
        print("Example: python3 update_pdf.py \"slopped german.pdf\" de")
        sys.exit(1)

    pdf_path = sys.argv[1]
    lang = sys.argv[2].lower()
    
    if not os.path.exists(pdf_path):
        print(f"Error: PDF not found at {pdf_path}")
        sys.exit(1)

    # Base directory logic (where the script is located)
    base_dir = os.path.dirname(os.path.abspath(__file__))
    images_dir = os.path.join(base_dir, "images")
    lang_img_dir = os.path.join(images_dir, lang)
    
    os.makedirs(lang_img_dir, exist_ok=True)
    
    print(f"Extracting {pdf_path} to {lang_img_dir}...")
    doc = fitz.open(pdf_path)
    for i in range(len(doc)):
        page = doc.load_page(i)
        pix = page.get_pixmap(dpi=150)
        out_path = os.path.join(lang_img_dir, f"page_{i+1:03d}.png")
        pix.save(out_path)
    
    print(f"Extraction complete: {len(doc)} pages extracted.")
    
    # 2. Rebuild index.html
    html_path = os.path.join(base_dir, "index.html")
    if not os.path.exists(html_path):
        print(f"Error: index.html not found at {html_path}")
        sys.exit(1)

    with open(html_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Determine languages and max pages
    all_langs = []
    max_pages = 0
    if os.path.exists(images_dir):
        for ld in os.listdir(images_dir):
            if os.path.isdir(os.path.join(images_dir, ld)):
                all_langs.append(ld)
                pgs = len(glob.glob(os.path.join(images_dir, ld, "page_*.png")))
                if pgs > max_pages:
                    max_pages = pgs

    # Split index.html
    start_idx = content.find('    <div class="gallery-container">')
    end_idx = content.find('    <script>')
    
    if start_idx == -1 or end_idx == -1:
        print("Error: Could not find gallery-container boundaries in index.html")
        sys.exit(1)
        
    prefix = content[:start_idx]
    suffix = content[end_idx:]
    
    html_blocks = []
    html_blocks.append('    <div class="gallery-container">\n')
    
    # Inject styling to hide missing pages accurately
    style_block = "        <style>\n"
    for l in all_langs:
        style_block += f'            [data-lang="{l}"] .missing-{l} {{ display: none !important; }}\n'
    style_block += "        </style>\n"
    html_blocks.append(style_block)
    
    for i in range(1, max_pages + 1):
        # find which langs have this page
        present_langs = []
        for l in all_langs:
            if os.path.exists(os.path.join(images_dir, l, f"page_{i:03d}.png")):
                present_langs.append(l)
        
        missing_classes = " ".join([f"missing-{l}" for l in all_langs if l not in present_langs])
        
        wrapper_class = f"page-wrapper {missing_classes}".strip()
        html_blocks.append(f'        <div class="{wrapper_class}">\n')
        
        # Sort languages so they appear consistently e.g., de, en, es.
        for l in sorted(present_langs):
            html_blocks.append(f'            <img class="lang-{l} page-img" src="images/{l}/page_{i:03d}.png" loading="lazy" alt="Page {i} {l.upper()}">\n')
        
        html_blocks.append('        </div>\n')
        
        # Link block after page 17
        if i == 17:
             link_block = '''
        <a href="/games/schnickschnack/"
            style="display: block; width: fit-content; margin: 10px auto 40px auto; padding: 15px 30px; background: #5ce73c; color: #1A1A1A; text-decoration: none; font-weight: bold; border: 2px solid #1A1A1A; box-shadow: 4px 4px 0px #1A1A1A; text-transform: uppercase; text-align: center; font-size: 1.1rem; transition: transform 0.2s;">
            <span class="lang-en">More information about SchnickSchnack</span>
            <span class="lang-de">Mehr Informationen über SchnickSchnack</span>
            <span class="lang-es">Más información sobre SchnickSchnack</span>
        </a>\n'''
             html_blocks.append(link_block)
             
    html_blocks.append('    </div>\n\n')
    
    new_content = prefix + "".join(html_blocks) + suffix
    
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(new_content)
        
    print(f"Successfully updated index.html to support up to {max_pages} pages across {len(all_langs)} languages.")

if __name__ == "__main__":
    main()
