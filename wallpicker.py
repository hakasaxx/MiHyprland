import os
import subprocess
os.system("clear")
def main():
    wallpaper_dir="/home/hakasax/Wallpapers"
    if not os.path.exists(wallpaper_dir):
        print(f"Error: La carpeta {wallpaper_dir} no existe")
        return
    extensiones=('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp')
    wallpapers=[]
    for archivo in os.listdir(wallpaper_dir):
        if archivo.lower().endswith(extensiones):
            wallpapers.append(archivo)
    wallpapers.sort()
    if not wallpapers:
        print(f"No hay nada q wea, descargalos y ponlos en {wallpaper_dir}")
        return
    print("Imagenes disponibles:")
    for i, wp in enumerate(wallpapers, start=1):
        print(f"{i}. {wp}")
    while True:
        try:
            seleccion=input("\nSelecciona el fondo: ")
            indice=int(seleccion)-1
            if 0<=indice<len(wallpapers):
                break
            else:
                print(f"Elige entre 1 y {len(wallpapers)} AWEONAO")
        except ValueError:
            print("No podi ser tan wn")
    wallpaper_path=os.path.join(wallpaper_dir, wallpapers[indice])
    try:
        subprocess.run(["awww", "img", wallpaper_path], check=True)
        subprocess.run(["wal", "-i", wallpaper_path], check=True)
        subprocess.run(["hyprctl", "reload"], check=True)
        print(f"\nWallpaper cambiado a: {wallpapers[indice]}")
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar awww: {e}")
    except FileNotFoundError:
        print("ERROR NO SE ENCONTRO AWWW INSTALALO CON: sudo pacman -S awww")
        subprocess.run(["sudo", "pacman", "-S", "awww"])
        subprocess.run(["awww", "img", wallpaper_path], check=True)
        subprocess.run(["wal", "-i", wallpaper_path], check=True)
        subprocess.run(["hyprctl", "reload"], check=True)
        print(f"\nWallpaper cambiado a: {wallpapers[indice]}")
if __name__=="__main__":
    main()
