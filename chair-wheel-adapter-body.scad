use <chair-wheel-adapter.scad>
include <options.scad>

cwa_body (
    bottom_radius = body_bottom_diameter / 2,
    top_radius = body_top_diameter / 2,
    h = body_height,
    ridge_h = ridge_height,
    legs_d = legs_diameter,
    legs_root_h = legs_root_length,
    shaft_id = shaft_inner_diameter,
    shaft_od = shaft_outer_diameter,
    fillet_h = fillet_height,
    fillet_w = fillet_width,
    with_socket = true
);
