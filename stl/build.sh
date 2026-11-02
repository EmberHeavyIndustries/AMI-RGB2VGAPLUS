#!/bin/sh
set -eu
cd "$(dirname "$0")"
if [ -n "${OPENSCAD_BIN:-}" ]; then
    cad_bin=$OPENSCAD_BIN
elif command -v openscad >/dev/null 2>&1; then
    cad_bin=openscad
else
    cad_bin=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
fi
for piece in base lid print; do
    case "$piece" in
        print) output=print-both.stl ;;
        *) output=$piece.stl ;;
    esac
    "$cad_bin" --backend CGAL --hardwarnings --export-format binstl \
        -D "part=\"$piece\"" -o "$output" ami-rgb2vgaplus.scad
done
"$cad_bin" --hardwarnings -D 'part="assembled"' \
    -o preview.png --imgsize 1400,1000 \
    --camera 90,-110,90,18,0,3 --viewall --autocenter --render \
    --colorscheme Tomorrow ami-rgb2vgaplus.scad
"$cad_bin" --hardwarnings -D 'part="assembled"' -o db23.png \
    --imgsize 1400,1000 --camera -90,-110,70,16,0,3 \
    --viewall --autocenter --render --colorscheme Tomorrow ami-rgb2vgaplus.scad
"$cad_bin" --hardwarnings -D 'part="exploded"' -o exploded.png \
    --imgsize 1400,1100 --camera 90,-110,100,18,0,8 \
    --viewall --autocenter --colorscheme Tomorrow ami-rgb2vgaplus.scad
"$cad_bin" --hardwarnings -D 'part="section"' -o section.png \
    --imgsize 1400,900 --camera 55,-110,45,18,0,3 \
    --viewall --autocenter --colorscheme Tomorrow ami-rgb2vgaplus.scad
"$cad_bin" --hardwarnings -D 'part="assembled"' -D 'show_pcb=false' \
    -o profile.png --imgsize 1400,700 --camera 18,-110,3,18,0,3 \
    --projection o --viewall --autocenter --render \
    --colorscheme Tomorrow ami-rgb2vgaplus.scad
