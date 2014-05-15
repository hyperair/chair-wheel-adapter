use <fillets.scad>

shaft_diameter = 10;
fillet_height = 1.5;
body_height = 6;

clearance = 0.1;

$fa = 1;
$fs = 0.5;

// body
difference () {
    union () {
        cylinder (d=shaft_diameter + 10, h=body_height);
        // outer fillet
        translate ([0, 0, body_height - 0.1])
        fillet (shaft_diameter/2 + clearance - 0.1, fillet_height + 0.1);
    }

    // shaft
    translate ([0, 0, -0.1])
    cylinder (
        r=shaft_diameter/2 + clearance,
        h=body_height + 0.2 + fillet_height
    );

    // inner fillet
    translate ([0, 0, -0.1])
    fillet (shaft_diameter/2 - 0.1, fillet_height + 0.1);
}
