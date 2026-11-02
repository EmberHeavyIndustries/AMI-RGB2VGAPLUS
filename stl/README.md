# AMI-RGB2VGAPLUS clip enclosure

A two-piece enclosure for this repository's V2 PCB, with four snap latches,
rounded edges, a tapered plan outline, and solid ribs separated by shallow
recessed grooves. Both halves flare outward at the DB23 end to surround its
metal flange, with a 1.00 mm front lip and access to both mounting holes.
A short, deep pocket surrounds the DB23; the underside rises
immediately behind it, keeping the rest of the base close to the PCB and
solder tails. The roof rises separately at the higher VGA connector.
A thin, tapered rim extends beyond the VGA-side PCB edge, keeping the
laminate inside the case while the connector face remains accessible.
Its underside rises beyond the solder tails, reducing the end-rim height
to 3.1 mm; the rim wall and floor are each 1.0 mm thick.

**First-print prototype: digitally checked, not physically test-fitted.**
The default assumes a 1.6 mm PCB and a solder-cup DB23 centred on its thickness.

![Enclosure](case.png)

## Files

- `base.stl`: base, lower DB23 pad on the bed; includes all four flexible clips.
- `lid.stl`: lid, standing on its VGA end.
- `print-both.stl`: both parts in those orientations, separated on the bed.
- `ami-rgb2vgaplus.scad`: editable OpenSCAD source; assembly views import
  the connector meshes from `../Hardware/3D/`.
- `build.sh`: regenerate the STLs and previews with OpenSCAD.

STL units are millimetres. Print at 100% scale. The assembled plastic envelope
is approximately **50.01 mm long × 52.97 mm wide × 23.26 mm high**.
The maximum width is at the DB23 flare; the middle is 43.97 mm wide, increasing locally to 44.69 mm at the
reinforced clip sockets.
Exposed connector mating shells are outside that envelope.

## Printing and assembly

### Optional FDM settings

Suggested starting settings: 0.4 mm nozzle, 0.20 mm layers, four perimeters,
and 20–25% infill. PETG is a sensible starting material for the flexible clips;
printer calibration and material still determine their real behaviour.

Print the base on its lower DB23 pad as exported, with removable support
under the short DB23 ramp and raised floor. The raised floor no
longer lies on the print bed. The rise is immediately behind the DB23, so
support is needed under most of the base, not just the VGA end. Keep support
out of the flexible clip slots.
For the upright lid, use a 5 mm brim and
paint small removable supports under the four PCB stops and two locating
keys. Inspect the slicer's layer preview for those inward projections and
the upper DB23 opening bridge. Keep support out of clip windows. The stepped
roof itself builds upright; there is no large unsupported horizontal roof.

### Assembly

Remove any brim, support, or first-layer expansion at mating surfaces.
Place the PCB on the six edge ledges, with DB23 at the wide/low end. Lower the
lid vertically, engage the locating keys, then press over the four clip
positions. Four stops retain the PCB with 0.20 mm nominal vertical play.
The case supports the board edges and leaves the VGA solder tails clear.

For removal, gently push the hooks inward through their side windows while
lifting the lid. Do not pull on the connector or pry against the PCB.

If the latch is too tight, increase `snap_clearance` slightly or reduce
`snap_engagement`, then regenerate **both** halves. Adjust PCB/connector
clearances independently rather than scaling the whole STL.

## Regenerating

From the repository root:

```sh
sh STL/build.sh
```

The script finds `openscad` on PATH or the macOS application. Override it with
`OPENSCAD_BIN=/path/to/openscad sh STL/build.sh`. It uses the CGAL backend for
repeatable, watertight STL exports; OpenSCAD 2026.06.12 was used here.

In the OpenSCAD customizer, `part` selects `print`, `base`, `lid`, `assembled`,
`exploded`, `section`, or `pcb`. The current selection is `assembled`, showing
the case and connectors together. Both F5 and F6 show the imported
connector detail. Select `print`, `base`, or `lid` for printable exports;
those outputs exclude the PCB and connectors.

## License

Copyright © 2026 Stefan Reinauer

The enclosure design (`base.stl`, `lid.stl`, `print-both.stl`,
`ami-rgb2vgaplus.scad` and `build.sh`) is licensed under the
[Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).
You may use, modify, sell and print it, including commercially, provided you
credit the author, link to the license and indicate any changes.

This license covers only the files listed above:

- The connector models in `../Hardware/3D/` are not included. They have their
  own sources and terms, described in the README in each model's folder.
  The DB23 model is CC BY-SA 4.0.
- Renders showing those connectors, including `case.png`, are not included.
- The PCB design and the rest of this repository are under the separate
  CC BY-NC-SA 4.0 license stated in the top-level README.

