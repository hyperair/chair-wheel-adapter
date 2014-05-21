use <chair-wheel-adapter.scad>
include <options.scad>

// Rotate 90° for printing to strengthen the legs
rotate ([0, 90, 0])
cwa_legs (
    d = legs_diameter,
    inner_d = shaft_outer_diameter,
    h = legs_height,
    root_h = legs_root_length,
    number_of_spokes = number_of_spokes,
    spoke_thickness = spoke_thickness,
    spoke_z_offset = spoke_z_offset
);
