# BOOMELE VGA-002 — LCSC C138387

Downloaded 2026-10-14 from the **JLCEDA/EasyEDA Official Library**
([JLCEDA](https://lceda.cn/), [EasyEDA](https://easyeda.com/)).
The repository BOM identifies this connector as DSUB2.

- `VGA-002.step`: downloaded STEP AP214 CAD model, with millimetre units.
- `VGA-002.obj`: downloaded EasyEDA mesh, including its inline material
  definitions. Some OBJ readers may ignore those material definitions.
- `VGA-002.stl`: millimetre STL converted from the downloaded OBJ, with
  its original coordinates preserved; suitable as an OpenSCAD reference.
- `VGA-002-solid.stl`: watertight STEP tessellation used by the enclosure
  assembly views, including sockets, fixing screws and solder tails.
- `easyeda-component.json`: original library response, preserving part
  identification, footprint placement metadata and copyright information.

The OBJ-derived STL contains 16,975 triangles. Its mesh envelope is approximately
31.10 mm wide × 21.70 mm deep × 15.812 mm high, including solder tails.
The original mesh is not watertight; use the STEP for solid CAD work.
This is a connector reference model, not a printable enclosure part.

These are library coordinates, not the enclosure's assembly coordinates:
X crosses the connector, Y runs along its depth, and Z is vertical.
Mesh bounds in millimetres are X = −15.550…15.550,
Y = −16.700…5.000, Z = −3.162…12.650.
The STEP has now been loaded and validated with Open CASCADE. Its three
solids tessellate to a watertight 139,028-triangle mesh, with a small rear
detail reaching Y=5.01. Regenerate it with `../tessellate.py` (cadquery-ocp
8.0.1.1.0 was used). Deflections are 0.025 mm linear and 0.15 rad angular.

The enclosure rotates the model 90 degrees about Z and translates it by
`[vga_flange_x-10.7, vga_center_y, vga_center_z-6.35]`. No scaling is used.

## Retrieval

The [C138387 component API](https://easyeda.com/api/products/C138387/components)
links footprint `D-SUB-TH_VGA-002` to model UUID
`ee2b103a6c6647af9c1561d90cb71abe` in its `SVGNODE` attributes.

- [STEP download](https://modules.easyeda.com/qAxj6KHrDKw4blvCG8QJPs7Y/ee2b103a6c6647af9c1561d90cb71abe)
- [OBJ download](https://modules.easyeda.com/3dmodel/ee2b103a6c6647af9c1561d90cb71abe)
- [LCSC product](https://www.lcsc.com/product-detail/C138387.html)

Both downloads arrived gzip-compressed and were decompressed without
modifying their contents. The STEP header identifies SolidWorks 2020
and the original filename `D-SUB-TH_VGA-002.step`; this does not establish
that it is a manufacturer-issued model.
