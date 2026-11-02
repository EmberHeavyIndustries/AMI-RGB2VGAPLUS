#!/usr/bin/env python3
"""Regenerate OpenSCAD reference meshes; requires cadquery-ocp and trimesh."""
from pathlib import Path

import trimesh
from OCP.BRepCheck import BRepCheck_Analyzer
from OCP.BRepMesh import BRepMesh_IncrementalMesh
from OCP.IFSelect import IFSelect_RetDone
from OCP.STEPControl import STEPControl_Reader
from OCP.StlAPI import StlAPI_Writer


root = Path(__file__).resolve().parent
for source, target, weld in [
    ("C138387/VGA-002.step", "C138387/VGA-002-solid.stl", False),
    ("DB23/DB23-female.step", "DB23/DB23-female.stl", True),
]:
    reader = STEPControl_Reader()
    assert reader.ReadFile(str(root / source)) == IFSelect_RetDone
    assert reader.TransferRoots() > 0
    shape = reader.OneShape()
    assert BRepCheck_Analyzer(shape).IsValid(), source
    BRepMesh_IncrementalMesh(shape, 0.025, False, 0.15, True).Perform()
    writer = StlAPI_Writer()
    writer.ASCIIMode = False
    assert writer.Write(shape, str(root / target))
    mesh = trimesh.load(root / target)
    if weld:
        mesh.merge_vertices(digits_vertex=6)
        mesh.update_faces(mesh.nondegenerate_faces())
        mesh.export(root / target)
    assert mesh.is_watertight and mesh.is_winding_consistent, target
    print(target, len(mesh.faces), "triangles; watertight")
