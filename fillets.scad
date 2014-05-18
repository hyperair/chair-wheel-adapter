$fa = 1;
$fs = 0.5;

module fillet (r, h, w=0)
{
    w = (w == 0) ? h : w;

    rotate_extrude ()
    translate ([r, 0, 0])
    polygon ([[0, 0], [0, h], [w, 0]]);
}

module fillet_mask (r, h, w=0)
{
    w = (w == 0) ? h : w;

    rotate_extrude ()
    translate ([r-h, 0, 0])
    polygon ([[w + 0.1, h + 0.1], [-0.1, h + 0.1], [w + 0.1, -0.1]]);
}

fillet_mask (r=10, h=1.5);
