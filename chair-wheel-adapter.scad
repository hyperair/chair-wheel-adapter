use <fillets.scad>

extra_height = 40;
body_diameter = 45;
shaft_diameter = 10;
neck_length = 25.4;
shaft_length = 25.4;
fillet_height = 1.5;
external_clearance = 0.3;
internal_clearance = 0.3;
body_height = max (extra_height, shaft_length);

$fa = 2;
$fs = 0.5;

module body ()
{
    cylinder (
        d = body_diameter,
        h = extra_height
    );
}

module shaft (d, h)
{
    render ()
    difference () {
        cylinder (d=d, h=h);
        translate ([0, 0, h - fillet_height])
        fillet_mask (d/2, fillet_height);
    }

    fillet (d/2 - 0.1, fillet_height + 0.1);
}

module neck ()
{
    cylinder (
        r = shaft_diameter/2 - external_clearance,
        h = neck_length - external_clearance
    );
}

// module shaft ()
// {
//     translate ([0, 0, -0.1])
//     cylinder (
//         r = shaft_diameter/2 + internal_clearance,
//         h = neck_length + internal_clearance + 0.1
//     );
// }


render ()
difference () {
    body ();
    shaft (d=shaft_diameter + internal_clearance*2, h=shaft_length);
}

translate ([0, 0, body_height])
shaft (d=shaft_diameter - external_clearance*2, h=neck_length);
