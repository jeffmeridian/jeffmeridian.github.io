from PIL import Image

def get_bbox(path):
    img = Image.open(path).convert("RGBA")
    bbox = img.getbbox()
    print(f"{path}: size={img.size}, bbox={bbox}")

get_bbox('assets/player.png')
get_bbox('assets/enemy.png')
