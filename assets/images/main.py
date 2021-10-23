import os
from PIL import Image

for subdir, dirs, files in os.walk("./"):
    for file in files:
        path = os.path.join(subdir, file)
        if path.endswith('.png'):
            img = Image.open(path)
            img = img.convert('RGBA')
            newImage = []
            for item in img.getdata():
                if item[:3] == (0, 0, 0):
                    newImage.append((0, 0, 0, 0))
                else:
                    newImage.append(item)

            img.putdata(newImage)

            img.save(path)
            print(file, "DOne")
            