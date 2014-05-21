use <fillets.scad>
include <options.scad>

$fa = 2;
$fs = 0.5;

module cwa_spokes (number_of_spokes, length, thickness, h)
{
    linear_extrude (h=h)
    for (angle = [0:360/number_of_spokes:359.9]) {
        rotate ([0, 0, angle])
        translate ([-thickness / 2, 0, 0])
        square (size=[thickness, length]);
    }
}

module cwa_legs (
    d, inner_d, h, root_h,
    number_of_spokes, spoke_thickness, spoke_z_offset
)
{
    difference () {
        cylinder (d=d, h=h + root_h);

        translate ([0, 0, root_h + spoke_z_offset - 0.1])
        cwa_spokes (
            number_of_spokes=number_of_spokes,
            length=d/2 + 0.1,
            thickness=spoke_thickness,
            h=h+0.2
        );

        translate ([0, 0, -0.1])
        cylinder (d = inner_d, h = h + root_h + 0.2);
    }
}

module cwa_body (
    bottom_radius, top_radius, h, ridge_h,
    legs_d, legs_root_h,
    shaft_id, shaft_od,
    fillet_h, fillet_w,
)
{
    difference () {
        union () {
            // body
            cylinder (
                r1 = bottom_radius,
                r2 = top_radius,
                h = h
            );

            // fillet in the middle of legs
            translate ([0, 0, h])
            fillet (r=shaft_id / 2, h=fillet_h, w=fillet_w);

            // raised ridges, because the shaft is slightly taller
            translate ([0, 0, h - 0.1])
            difference () {
                cylinder (r=top_radius, h=ridge_h + 0.1);
                translate ([0, 0, -0.1])
                cylinder (d=legs_d, h=ridge_h + 0.3);
            }
        }

        // shaft hole
        translate ([0, 0, -0.1]) {
            cylinder (
                r = shaft_id / 2,
                h = h + 0.2
            );

            // expanded fillet for subtraction
            fillet (
                r = shaft_id / 2 - 0.1,
                h = fillet_h + 0.1,
                w = fillet_w + 0.1 + 0.1 / fillet_h * fillet_w
            );
        }
    }
}

// Fully assembled chair wheel adapter for viewing
module chair_wheel_adapter (
    legs_diameter = legs_diameter,
    legs_height = legs_height,
    legs_root_length = legs_root_length,
    number_of_spokes = number_of_spokes,
    spoke_thickness = spoke_thickness,
    spoke_z_offset = spoke_z_offset,
    body_bottom_diameter = body_bottom_diameter,
    body_top_diameter = body_top_diameter,
    shaft_inner_diameter = shaft_inner_diameter,
    shaft_outer_diameter = shaft_outer_diameter,
    fillet_height = fillet_height,
    fillet_width = fillet_width,
    body_height = body_height,
    ridge_height = ridge_height
)
{
    body_top_radius = body_top_diameter / 2;
    body_bottom_radius = body_top_radius / 2;
    shaft_wall_thickness_outside_fillet =
        (shaft_outer_diameter - shaft_inner_diameter) / 2 -
        fillet_width;

    union () {
        translate ([0, 0, body_height - legs_root_length])
        cwa_legs (
            d=legs_diameter,
            inner_d = shaft_outer_diameter,
            h=legs_height,
            root_h = legs_root_length,
            number_of_spokes=number_of_spokes,
            spoke_thickness=spoke_thickness,
            spoke_z_offset=spoke_z_offset
        );

        cwa_body (
            bottom_radius = body_bottom_radius,
            top_radius = body_top_radius,
            h = body_height,
            ridge_h = ridge_height,
            legs_d = legs_diameter,
            legs_root_h = legs_root_length,
            shaft_id = shaft_inner_diameter,
            shaft_od = shaft_outer_diameter,
            fillet_h = fillet_height,
            fillet_w = fillet_width
        );
    }
}

rotate ([0, 90, 0])
chair_wheel_adapter ();
