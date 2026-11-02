# DB23 female connector model

Source: [jbilander / Amiga_RGB_video_splitter](https://github.com/jbilander/Amiga_RGB_video_splitter/blob/82b32b9c82162615b77e34f15fb121769ae955da/KiCad/packages3d/D-SUB_DB23_Female.stp),
downloaded 2026-10-14. Upstream supplies this under CC BY-SA 4.0;
the license is retained in `LICENSE`.

`DB23-female.step` is the unmodified downloaded STEP. `DB23-female.stl`
is its Open CASCADE tessellation (0.025 mm linear, 0.15 rad angular
deflection). Coincident vertices were welded to six decimal places and
four degenerate triangles removed. The resulting mesh is watertight.

This is a detailed 23-socket connector model, including its D-shaped
shell, mounting holes, insulator shape and contacts. It has **straight
rear pins**, whereas the repository board photo uses **solder cups**.
It is not verified as the exact manufactured part used on this PCB.
The supplied AmigaStore photo confirms the female mating-face style.

The flange is 50.28 × 12.55 mm. Library coordinates span
X = −23.755…26.525, Y = −5.8…10.6, Z = −6.275…6.275 mm.
The width centre is X=1.385; the rear flange face is Y=0.77, and the
rear contact collars finish at Y=6.4. The enclosure maps local +Y to
assembly +X, puts those collars at PCB X=0, and centres the connector
vertically on the assumed 1.6 mm laminate. Actual soldered placement
remains a fit assumption.

The rear-body clearance envelope is 38.67 × 11.05 mm before print
clearance. No model scaling or DB25-to-DB23 resizing was applied.
