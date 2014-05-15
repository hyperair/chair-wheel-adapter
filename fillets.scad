$fa = 1;
$fs = 0.5;

module fillet (r, h)
{
    rotate_extrude ()
    translate ([r, 0, 0])
    polygon ([[0, 0], [0, h], [h, 0]]);
}

module fillet_mask (r, h)
{
    rotate_extrude ()
    translate ([r-h, 0, 0])
    polygon ([[h + 0.1, h + 0.1], [-0.1, h + 0.1], [h + 0.1, -0.1]]);
}

fillet_mask (r=10, h=1.5);
