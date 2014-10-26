extra = 0.1;
wall_thickness = 1.5;

module base()
{
    pcb_w = 25.3;
    pcb_l = 12.6;
    pcb_thickness = 1.6;
    pcb = [pcb_w, pcb_l, pcb_thickness + extra];

    case_h = 4;
    outside = [pcb_w + 2 * wall_thickness, pcb_l + 2 * wall_thickness, case_h];

    lip = 0.6;
    cavity = [pcb_w - 2 * lip, pcb_l - 2 * lip, 3];

    difference() {
        translate([-1 * wall_thickness, -1 * wall_thickness, 0]) cube(outside);
        translate([0, 0, -1 * extra]) cube(pcb);
        translate([lip, lip, 0]) cube(cavity);
    }
}

module cable_gap()
{
    h = 3.6 + extra;
    w = 13;
    d = 2.5 + wall_thickness + extra;
    gap = [w, d, h];

    translate([10.2, -1 * (wall_thickness + extra), -1 * extra]) cube(gap);
}

module case()
{
    difference() {
        base();
        cable_gap();
        translate([0, 0, -1 * extra]) d_pad(x = 0.5, h = 4 + 2 * extra);
        translate([0, 0, -1 * extra]) a_button(x = 0.5, h = 4 + 2 * extra);
        translate([0, 0, -1 * extra]) b_button(x = 0.5, h = 4 + 2 * extra);
        translate([0, 0, -1 * extra]) start_button(x = 0.5, h = 4 + 2 * extra);
        translate([0, 0, -1 * extra]) select_button(x = 0.5, h = 4 + 2 * extra);
    }
}

module d_pad(x, h)
{
    w = 2.5 + x;
    l = 8.3 + x;

    translate([15.9 + x / -2, 2.4 + x / -2, 0]) union() {
        translate([(l - w) / 2, 0, 0]) cube([w, l, h]);
        translate([0, (l - w) / 2, 0]) cube([l, w, h]);
    }
}

module regular_button(x, h)
{
    radius = 1.25 + x/2;
    cylinder (h = h, r = radius, $fn = 100);
}

module a_button(x, h)
{
    translate([2, 10, 0]) regular_button(x = x, h = h);
}

module b_button(x, h)
{
    translate([5, 10, 0]) regular_button(x = x, h = h);
}

module option_button(x, h)
{
    l = 1 + x;
    r = l / 2;
    w = 2.5 - l + x;
    union() {
        translate([w / -2, l / -2, 0]) cube([w, l, h]);
        translate([w / -2, 0, 0]) cylinder(h = h, r = r, $fn = 100);
        translate([w / 2, 0, 0]) cylinder(h = h, r = r, $fn = 100);
    }
}

module start_button(x, h)
{
    translate([10.5, 10, 0]) option_button(x = x, h = h);
}

module select_button(x, h)
{
    translate([13.5, 10, 0]) option_button(x = x, h = h);
}

module button_plate()
{
    w = 25.3;
    l = 12.6;
    thickness = 0.3;

    margin = 0.8;
    cavity = [w - 2 * margin, l - 2 * margin, thickness];

    difference() {
        translate([margin, margin, 0]) cube(cavity);
        translate([0, 0, -1 * extra]) cube([15, 8.5, thickness + 2 * extra]);
        cable_gap();
    }
}

module buttons()
{
    button_h = 2;
    translate([0, 0, 2.75]) union() {
        d_pad(x = 0, h = button_h);
        a_button(x = 0, h = button_h);
        b_button(x = 0, h = button_h);
        start_button(x = 0, h = button_h);
        select_button(x = 0, h = button_h);
        button_plate();
    }
}

case();
buttons();
