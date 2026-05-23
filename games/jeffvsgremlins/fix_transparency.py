from PIL import Image
import glob
import os

def fix_image(filepath):
    try:
        img = Image.open(filepath).convert("RGBA")
        datas = img.getdata()
        new_data = []
        
        # Determine background color by sampling top-left pixel
        bg_color = datas[0]
        
        for item in datas:
            # Check if it's a checkerboard pattern (light greys and whites)
            # DALL-E often uses alternating greys/whites for "transparent" background
            if item[0] > 180 and item[1] > 180 and item[2] > 180 and abs(item[0]-item[1]) < 20 and abs(item[1]-item[2]) < 20:
                new_data.append((255, 255, 255, 0)) # fully transparent
            else:
                new_data.append(item)
                
        img.putdata(new_data)
        img.save(filepath, "PNG")
        print(f"Fixed {filepath}")
    except Exception as e:
        print(f"Error on {filepath}: {e}")

for f in glob.glob("assets/*.png"):
    if "background" not in f:
        fix_image(f)
