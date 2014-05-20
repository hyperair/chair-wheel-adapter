use <fillets.scad>

$fa = 2;
$fs = 0.5;

module spokes (number_of_spokes, length, thickness, h)
{
    linear_extrude (h=h)
    for (angle = [0:360/number_of_spokes:359.9]) {
        rotate ([0, 0, angle])
        translate ([-thickness / 2, 0, 0])
        square (size=[thickness, length]);
    }
}

module legs (d, h, number_of_spokes, spoke_thickness, spoke_z_offset)
{
    difference () {
        cylinder (d=d, h=h);
        translate ([0, 0, spoke_z_offset - 0.1])
        spokes (
            number_of_spokes=number_of_spokes,
            length=d/2 + 0.1,
            thickness=spoke_thickness,
            h=h+0.2
        );
    }
}

module chair_wheel_adapter (
    legs_diameter = 30,
    legs_height = 20,
    number_of_spokes = 6,
    spoke_thickness = 1,
    spoke_z_offset = 2.75,
    body_bottom_diameter = 18,
    body_top_diameter = 35,
    shaft_inner_diameter = 10,
    shaft_outer_diameter = 18,
    internal_clearance = 0.1,
    fillet_height = 3,
    fillet_width = 2,
    body_height = 20
)
{
    body_top_radius = body_top_diameter / 2;
    body_bottom_radius = body_top_radius / 2;

    difference () {
        union () {
            translate ([0, 0, body_height])
            difference () {
                legs (
                    d=legs_diameter,
                    h=legs_height,
                    number_of_spokes=number_of_spokes,
                    spoke_thickness=spoke_thickness,
                    spoke_z_offset=spoke_z_offset
                );

                translate ([0, 0, -0.1])
                cylinder (d=shaft_outer_diameter, h=legs_height + 0.2);
            }

            // body
            cylinder (
                r1=body_bottom_radius, r2=body_top_radius,
                h=body_height
            );

            translate ([0, 0, body_height])
            fillet (r=shaft_inner_diameter/2, h=fillet_height, w=fillet_width);
        }

        // shaft hole
        translate ([0, 0, -0.1]) {
            cylinder (
                r=shaft_inner_diameter/2 + internal_clearance,
                h=legs_height + body_height + 0.2
            );

            // expanded fillet for subtraction
            fillet (
                r=shaft_inner_diameter/2 - 0.1,
                h=fillet_height + 0.1,
                w=fillet_width + 0.1 + 0.1 / fillet_height * fillet_width
            );
        }
    }
}

chair_wheel_adapter ();
