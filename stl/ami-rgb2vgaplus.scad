// AMI-RGB2VGAPLUS V2 enclosure, dimensions in mm.
// Copyright (c) 2026 Stefan Reinauer
// SPDX-License-Identifier: CC-BY-4.0
// CBY resin revision: DFM3 base join correction; DFM2 lid unchanged.
// PCB outline: repository Gerber, not the smaller reference adapter.
// X: DB23 -> VGA. Y: across board. Z=0: component-side PCB surface.
// DB23 uses solder cups straddling the PCB; verify on the first print.

/* [Output] */
part = "assembled"; // [print, base, lid, assembled, exploded, section, pcb]
show_pcb = true;

/* [Fit] */
pcb_thickness = 1.6;
pcb_clearance = 0.30;
connector_clearance = 0.35;
wall = 2.0;
floor_thickness = 1.8;
roof_thickness = 1.8;
thin_wall = 1.0;

/* [DB23 - solder-cup body, NOT a DB25 width] */
// Rear-body envelope measured from the DB23 STEP. Fixing holes stay accessible.
db23_body_width = 38.67;
db23_body_height = 11.05;
db23_center_z = -pcb_thickness / 2;
// Rear flange face; model rear contact collars meet the PCB edge at X=0.
db23_flange_x = -5.63;
// CBY revision: reinforce the flange lip flagged by the print service.
db23_front_lip = thin_wall;
// Broaden only the DB23 end to surround the full flange and fixing ears.
db23_flange_width = 50.28;
db23_flare_end = 4.5;

/* [VGA - BOOMELE VGA-002, LCSC C138387] */
// Drawing: 31 x 12.5 flange, 25 mm screw pitch, 10.5 mm body height.
// Use the slightly larger OBJ envelope and its placed centre for clearance.
vga_center_z = 6.312;
vga_center_y = 0.023;
vga_body_width = 31.10;
vga_body_height = 12.65;
vga_flange_x = 40.291;
// Lowest metal in the supplied OBJ, relative to the PCB top. The linked
// VGA-002 drawing does not specify vertical pin projection below the PCB.
vga_tail_bottom = -3.20;
// Thin rim around the PCB edge; the solder tails end before this region.
vga_rim_wall = thin_wall;
vga_rim_floor = thin_wall;

/* [Snap fit] */
snap_clearance = 0.20;
snap_engagement = 0.35;

/* [Underside profile] */
// Measured from the DB23-side PCB edge, independently of the roof ramp.
bottom_ramp_start = 1.5;
bottom_ramp_end = 4.5;

/* [Appearance] */
corner_radius = 1.1;
edge_radius = 0.7;
groove_depth = 0.55;
groove_width = 1.1;
groove_pitch = 3.2;

/* [Hidden] */
$fn = 40;
eps = 0.02;
board_length = 40.513;
wide_half = 19.685;
narrow_half = 15.494;
shoulder_start = 19.685;
shoulder_end = 24.638;
db23_flange_depth = 1.09;
db23_flange_height = 12.55;
// Keep full width behind the flange pocket before starting the taper.
// Otherwise the pocket cuts nearly through the sloping ear surround.
db23_collar_end = db23_flange_x+connector_clearance+wall;
front_x = db23_flange_x-db23_flange_depth
          -connector_clearance-db23_front_lip;
front_half = db23_flange_width/2+connector_clearance-pcb_clearance
             -wall+thin_wall;
rear_x = vga_flange_x - 0.4;
// The upper shell stops behind the VGA flange, but the base surrounds
// the laminate projecting beneath it. Leave clearance to both PCB and metal.
vga_guard_inner_x = max(board_length+pcb_clearance,
                        vga_flange_x+0.3+connector_clearance);
vga_guard_end_x = vga_guard_inner_x+vga_rim_wall;
vga_guard_top = 0.15;
vga_guard_start = rear_x-wall;
vga_guard_floor = -pcb_thickness-connector_clearance;
vga_guard_bottom = vga_guard_floor-vga_rim_floor;
bottom_z = min(-8.3, db23_center_z-db23_body_height/2
              -connector_clearance-floor_thickness,
              db23_center_z-db23_flange_height/2-connector_clearance-thin_wall);
rear_bottom = min(-pcb_thickness, vga_tail_bottom)
              -connector_clearance-floor_thickness;
front_top = max(7.5, db23_center_z+db23_body_height/2
                +connector_clearance+roof_thickness);
rear_top = vga_center_z+vga_body_height/2
           +connector_clearance+roof_thickness;
split_z = 2.1;
ramp_start = 19.0;
ramp_end = 25.8;
inner_y = wide_half + pcb_clearance;
outer_y = inner_y + wall;
arm_inner = inner_y + 0.16;
arm_thickness = 1.0;
arm_outer = arm_inner + arm_thickness;
arm_width = 4.6;
arm_root = rear_bottom+floor_thickness-0.1;
arm_tip = 5.5;
hook_z = 4.0;
hook_top = 4.65;
channel_outer = arm_outer + snap_clearance;
hook_outer = channel_outer + snap_engagement;
socket_skin = thin_wall;
socket_outer = max(outer_y,channel_outer+socket_skin);
snap_x = [7.0, 17.0];
support_x = [6.8, 17.5];

assert(pcb_thickness > 0 && pcb_clearance >= 0);
assert(wall >= 1.8 && groove_depth < roof_thickness-0.9);
assert(snap_clearance >= 0.1 && snap_engagement > 0);
assert(hook_outer < outer_y-0.1, "Hook must stay inside outer wall");
assert(db23_body_width/2+connector_clearance < wide_half+pcb_clearance);
assert(rear_bottom > bottom_z, "VGA underside must be above DB23 underside");
assert(bottom_ramp_start < bottom_ramp_end);
assert(db23_flare_end < min(snap_x)-arm_width/2,
       "Finish the DB23 flare before the clip roots");
assert(bottom_ramp_end <= min(snap_x)-arm_width/2,
       "Finish the underside rise before the clip roots");
assert(bottom_ramp_end <= min(support_x)-1.4,
       "Finish the underside rise before the PCB supports");

module board_outline() {
    polygon([[0,-wide_half], [shoulder_start,-wide_half],
             [shoulder_end,-narrow_half], [board_length,-narrow_half],
             [board_length,narrow_half], [shoulder_end,narrow_half],
             [shoulder_start,wide_half], [0,wide_half]]);
}

// Extend around the central DB23 flange; leave the VGA upper edge behind
// its flange. Separate clearance cuts keep both mating faces accessible.
module footprint(delta=0) {
    offset(r=corner_radius)
        offset(delta=-corner_radius)
            offset(delta=delta)
                polygon([[front_x,-front_half],
                         [db23_collar_end,-front_half],
                         [db23_flare_end,-wide_half],
                         [shoulder_start,-wide_half],
                         [shoulder_end,-narrow_half],
                         [rear_x,-narrow_half], [rear_x,narrow_half],
                         [shoulder_end,narrow_half],
                         [shoulder_start,wide_half],
                         [db23_flare_end,wide_half],
                         [db23_collar_end,front_half],
                         [front_x,front_half]]);
}

// The deep pocket ends just behind DB23. The roof rises separately at VGA.
module outer_blank() {
    intersection() {
        minkowski() {
            intersection() {
                translate([0,0,bottom_z+edge_radius-0.05])
                    linear_extrude(rear_top-bottom_z-2*edge_radius+0.05)
                        footprint(pcb_clearance+wall-edge_radius);
                translate([0,60,0]) rotate([90,0,0]) linear_extrude(120)
                    offset(delta=-edge_radius)
                        polygon([[front_x-5,bottom_z-0.05],
                                 [bottom_ramp_start,bottom_z-0.05],
                                 [bottom_ramp_end,rear_bottom],
                                 [rear_x+5,rear_bottom],
                                 [rear_x+5,rear_top], [ramp_end,rear_top],
                                 [ramp_start,front_top],
                                 [front_x-5,front_top]]);
            }
            sphere(r=edge_radius,$fn=24);
        }
        // Bound the shell at the DB23 lip and upper VGA flange clearance.
        translate([front_x,-60,bottom_z])
            cube([rear_x-front_x,120,rear_top-bottom_z+1]);
    }
}

module cavity() {
    intersection() {
        translate([front_x+wall,-60,bottom_z])
            cube([rear_x-front_x-2*wall,120,rear_top-bottom_z+1]);
        translate([0,0,bottom_z+floor_thickness])
            linear_extrude(rear_top-bottom_z) footprint(pcb_clearance);
        translate([0,60,0]) rotate([90,0,0]) linear_extrude(120)
            polygon([[front_x-10,bottom_z+floor_thickness],
                     [bottom_ramp_start-0.6,bottom_z+floor_thickness],
                     [bottom_ramp_end-0.6,rear_bottom+floor_thickness],
                     [rear_x+10,rear_bottom+floor_thickness],
                     [rear_x+10,rear_top-roof_thickness],
                     [ramp_end+0.6,rear_top-roof_thickness],
                     [ramp_start+0.6,front_top-roof_thickness],
                     [front_x-10,front_top-roof_thickness]]);
    }
}

module rounded_aperture(x0, length, width, height, cy, cz, r=0.8) {
    translate([x0,cy,cz]) rotate([90,0,90])
        linear_extrude(length)
            offset(r=r) square([width-2*r,height-2*r],center=true);
}

module connector_openings() {
    rounded_aperture(front_x-4, 9,
        db23_body_width+2*connector_clearance,
        db23_body_height+2*connector_clearance, 0, db23_center_z);
    // Pocket wraps the metal flange; fixing holes have separate access.
    // The front lip overlaps only the flange perimeter, not the D-shell.
    translate([db23_flange_x-db23_flange_depth-connector_clearance,
               -db23_flange_width/2-connector_clearance,
               db23_center_z-db23_flange_height/2-connector_clearance])
        cube([db23_flange_depth+2*connector_clearance,
              db23_flange_width+2*connector_clearance,
              db23_flange_height+2*connector_clearance]);
    for (y=[-22.06,22.06])
        translate([front_x-1,y,db23_center_z]) rotate([0,90,0])
            cylinder(h=db23_flange_x-front_x+wall+2,r=2.2);
    rounded_aperture(rear_x-4, 9,
        vga_body_width+2*connector_clearance,
        vga_body_height+2*connector_clearance,
        vga_center_y, vga_center_z, 0.5);
    // The laminate continues under the VGA flange. Avoid trapping it
    // in an end wall placed in front of the actual PCB edge.
    translate([rear_x-4,-narrow_half-pcb_clearance,-pcb_thickness-0.25])
        cube([9,2*(narrow_half+pcb_clearance),pcb_thickness+0.5]);
}

// Shallow recessed channels leave solid ribs between them. These are
// cosmetic grooves, not holes through the roof. End caps are rounded.
module grooves() {
    for (x=[4.5:groove_pitch:18])
        translate([x,0,front_top-groove_depth])
            linear_extrude(groove_depth+1)
                offset(r=groove_width/2)
                    square([eps,2*(wide_half-2.3)],center=true);
    for (x=[29.3:groove_pitch:37])
        translate([x,0,rear_top-groove_depth])
            linear_extrude(groove_depth+1)
                offset(r=groove_width/2)
                    square([eps,2*(narrow_half-2.3)],center=true);
    // Short side flutes continue the retro rib pattern. Keep them away
    // from the snap roots and from the PCB support contacts. Stop below
    // the rounded roof edge: the former 7 mm top left a 0.427 mm cap.
    for (s=[-1,1], x=[4.5:groove_pitch:18])
        translate([x-groove_width/2,s*(outer_y-0.23)-0.35,front_top-2.9])
            cube([groove_width,0.70,2.9-edge_radius-thin_wall]);
}

module shell() {
    difference() {
        outer_blank();
        cavity();
        connector_openings();
        grooves();
    }
}

module on_sides() {
    for (s=[-1,1]) scale([1,s,1]) children();
}

// Vertical cantilevers are rooted at the base floor and flex inwards.
// The hook has a flat retention face and a sloping insertion face.
module snap_arm(x) {
    translate([x-arm_width/2,arm_inner,arm_root])
        cube([arm_width,arm_thickness,arm_tip-arm_root]);
    translate([x-arm_width/2,0,0]) rotate([90,0,90])
        linear_extrude(arm_width)
            polygon([[arm_outer-eps,hook_z], [hook_outer,hook_z],
                     [hook_outer,hook_top],
                     [arm_outer-eps,arm_tip-0.1]]);
}

module arm_relief(x) {
    // U-shaped relief prevents the base sidewall stiffening the beam.
    // Start inside the cavity so its rounded PCB shoulder cannot leave
    // a wafer along the inboard edge of the rear relief slots.
    for (dx=[-1,1])
        translate([x+dx*(arm_width/2+0.3)-0.3,inner_y-wall,arm_root+1.1])
            cube([0.6,2*wall+1,split_z-arm_root]);
    translate([x-arm_width/2-0.6,arm_outer,arm_root+1.1])
        cube([arm_width+1.2,wall+1,split_z-arm_root]);
}

module pcb_supports() {
    on_sides() for (x=support_x)
        translate([x-1.4,wide_half-0.95,
                   rear_bottom+floor_thickness-eps])
            cube([2.8,pcb_clearance+wall+0.95,
                  -pcb_thickness-rear_bottom-floor_thickness+eps]);
    // Narrow-end edge supports, outside the VGA's solder tails.
    on_sides() translate([33.2,narrow_half-0.85,
                         rear_bottom+floor_thickness-eps])
        cube([2.2,pcb_clearance+wall+0.85,
              -pcb_thickness-rear_bottom-floor_thickness+eps]);
}

module vga_pcb_guard() {
    // Taper the thin rim into the case; keep only PCB clearance under its end.
    half_start = narrow_half+pcb_clearance+wall;
    half_end = narrow_half+pcb_clearance+vga_rim_wall;
    // Begin inside the existing floor, above its rounded underside. Starting
    // at rear_bottom let this exact prism project below the tessellated shell
    // by 0.006 mm and form a knife edge at the start of the underside ramp.
    // The shell supplies the lower join; the ramp trims the exposed rim.
    guard_blank_bottom = rear_bottom+edge_radius;
    difference() {
        translate([0,0,guard_blank_bottom])
            linear_extrude(vga_guard_top-guard_blank_bottom)
                offset(r=0.4) offset(delta=-0.4)
                    polygon([[vga_guard_start,-half_start],
                             [vga_guard_end_x,-half_end],
                             [vga_guard_end_x,half_end],
                             [vga_guard_start,half_start]]);
        // Rising inner floor follows the underside relief, without exposing PCB.
        translate([0,narrow_half+pcb_clearance,0]) rotate([90,0,0])
            linear_extrude(2*(narrow_half+pcb_clearance))
                polygon([[vga_guard_start-1,rear_bottom+floor_thickness],
                         [vga_guard_start,rear_bottom+floor_thickness],
                         [rear_x,vga_guard_floor],
                         [vga_guard_inner_x,vga_guard_floor],
                         [vga_guard_inner_x,10],[vga_guard_start-1,10]]);
    }
}

module base_core() {
    difference() {
        union() {
            difference() {
                intersection() {
                    shell();
                    translate([-20,-60,bottom_z-1])
                        cube([90,120,split_z-bottom_z+1]);
                }
                on_sides() for (x=snap_x) arm_relief(x);
            }
            on_sides() for (x=snap_x) snap_arm(x);
            pcb_supports();
        }
        connector_openings();
        // Open the fixing-hole tops to the seam instead of leaving fragile
        // bridges above the bores. The lid closes these U-shaped notches.
        for (y=[-22.06,22.06])
            translate([front_x-1,y-2.2,db23_center_z])
                cube([db23_flange_x-front_x+wall+2,4.4,
                      split_z-db23_center_z+eps]);
        // Merge each mounting notch into the body opening. Their original
        // 0.175 mm separating posts cannot be printed reliably. Extend down
        // to the bottom of the bore so no thin crescent remains below it.
        on_sides()
            translate([front_x-1,db23_body_width/2+connector_clearance-eps,
                       db23_center_z-2.2])
                cube([db23_flange_x-front_x+wall+2,
                      22.06-db23_body_width/2-connector_clearance+eps,
                      split_z-db23_center_z+2.2+eps]);
        on_sides() translate([26.8,narrow_half-0.16,split_z-1.4])
            cube([3.4,thin_wall+2*snap_clearance,1.5]);
    }
    // Add after the upper shell's PCB relief cut, which deliberately runs
    // through the flange plane and must not remove this enclosing end wall.
    vga_pcb_guard();
}

module base() {
    difference() {
        base_core();
        // Remove the deep floor beyond the solder tails, including the join
        // to the rim. Its underside follows the selected thin-wall thickness.
        translate([0,60,0]) rotate([90,0,0]) linear_extrude(120)
            polygon([[vga_guard_start,-20], [60,-20],
                     [60,vga_guard_bottom], [rear_x,vga_guard_bottom],
                     [vga_guard_start,rear_bottom]]);
    }
}

module sockets() {
    on_sides() for (x=snap_x) {
        // Pocket for the arm, with clearance on all three sides.
        translate([x-arm_width/2-snap_clearance,inner_y-eps,split_z-eps])
            cube([arm_width+2*snap_clearance,
                  channel_outer-inner_y+eps,arm_tip-split_z+snap_clearance]);
        // Through window is also the release access for a small tool.
        translate([x-arm_width/2-snap_clearance,inner_y-eps,hook_z-0.15])
            cube([arm_width+2*snap_clearance,socket_outer-inner_y+1,
                  arm_tip-hook_z+0.30]);
    }
}

module socket_reinforcement() {
    // Local pads preserve the selected wall behind the arm pocket without widening
    // the whole case. Rounded ends merge into the existing side ribs.
    on_sides() for (x=snap_x)
        translate([0,socket_outer,0]) rotate([90,0,0])
            linear_extrude(socket_outer-outer_y+0.7)
                offset(r=0.2) offset(delta=-0.2)
                    translate([x-arm_width/2-snap_clearance-0.8,split_z])
                        square([arm_width+2*snap_clearance+1.6,
                                front_top-split_z]);
}

module lid_stops() {
    // Pair with the base ledges; 0.20 mm vertical PCB play.
    on_sides() for (x=support_x)
        translate([x-1.2,wide_half-1.1,0.20])
            cube([2.4,pcb_clearance+0.9,
                  front_top-roof_thickness-0.20+eps]);
    // Location tongues on the tapered sides, clear of the four clips.
    on_sides() translate([27,narrow_half+0.04,split_z-1.2])
        cube([3.0,thin_wall,2.0]);
}

module lid() {
    difference() {
        union() {
            intersection() {
                shell();
                translate([-20,-60,split_z]) cube([90,120,40]);
            }
            lid_stops();
            socket_reinforcement();
        }
        sockets();
        connector_openings();
    }
}

module pcb_preview() {
    color([0.33,0.15,0.43]) translate([0,0,-pcb_thickness])
        linear_extrude(pcb_thickness) board_outline();
    // C138387 library STEP tessellation, in millimetres. Its flange rear
    // face is at Y=-10.7, centre Z=6.35; rotate the mating face toward +X.
    color("silver")
        translate([vga_flange_x-10.7,vga_center_y,vga_center_z-6.35])
            rotate([0,0,90])
                import("../Hardware/3D/C138387/VGA-002-solid.stl");
    color("silver")
        // Detailed 23-socket library model; its straight rear pins differ
        // from the solder cups in the board photo. See Hardware/3D/DB23.
        translate([db23_flange_x-0.77,1.385,db23_center_z])
            rotate([0,0,-90])
                import("../Hardware/3D/DB23/DB23-female.stl");
}

module assembly(explode=0) {
    color([0.76,0.73,0.64]) base();
    translate([0,0,explode]) color([0.88,0.85,0.75]) lid();
    if (show_pcb) pcb_preview();
}

module base_print() { translate([0,0,-bottom_z]) base(); }
// The raised underside needs support beyond the small DB23 bed-contact pad.
// Stand the lid on its flat VGA end. The roof step then needs no support,
// and the four latches remain on the more compliant, flat-printed base.
module lid_print() { translate([0,0,rear_x]) rotate([0,90,0]) lid(); }

if (part=="base") base_print();
else if (part=="lid") lid_print();
else if (part=="print") {
    base_print();
    translate([62,0,0]) lid_print();
}
else if (part=="assembled") assembly();
else if (part=="exploded") assembly(16);
else if (part=="section") intersection() {
    assembly();
    translate([-20,0,-20]) cube([90,60,70]);
}
else if (part=="pcb") pcb_preview();
else assert(false,"Unknown part selection");
