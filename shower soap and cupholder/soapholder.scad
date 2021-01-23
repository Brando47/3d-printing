
use <wall_thickness.scad>;

$fn=50;

wt=wt(layer_height=0.15, extrusion_width=0.45, perimeters=6);
echo(str("Wall thickness: ", wt));

nothing=0.01;
//cup to fit ring in shower
module attachment_to_shower(max_d, min_d, h, drain_d, drain_h, fillet, wt, contact_d)
{
    
    contact_height=h*(contact_d-min_d)/(max_d-min_d);
    echo(str("Contact height: ", contact_height));
    
    rotate_extrude()
    offset(-5)
    offset(5+(wt/2-0.1))
    offset(-(wt/2-0.1))
    polygon([
        [min_d/2-wt,0],
        [max_d/2-wt,h],
        [max_d/2,h],
        [min_d/2,-wt],
        [min_d/2-fillet,-wt-fillet],
        [drain_d/2,-drain_h],
        [drain_d/2,-drain_h+wt],
        [min_d/2-wt-fillet,-fillet]
    ]);
}

module cup_holder(d, h, drain_d, drain_h, fillet, wt)
{
    rotate_extrude()
    offset(-5)
    offset(5+(wt/2-0.1))
    offset(-(wt/2-0.1))
    polygon([
        [d/2-wt,0],
        [d/2-wt,h],
        [d/2,h],
        [d/2,-wt],
        [d/2-fillet,-wt-fillet],
        [drain_d/2,-drain_h],
        [drain_d/2,-drain_h+wt],
        [d/2-wt-fillet,-fillet]
    ]);
}

module soap_holder(length, width, thickness, drain_d, drain_h, fillet, bump_r, wt)
{
    w=width-2*fillet;
    l=length-2*fillet;
    t=thickness-fillet;
    translate([0,0,-t-fillet])
    union()
    {
        difference()
        {
            minkowski()
            {
                difference()
                {
                    cube([l, w, 2*t], center=true);
                    translate([0,0,t/2-fillet/2+nothing])
                    cube([l-2*t, w-2*t, t+fillet], center=true);
                }
                sphere(fillet);
            }
            
            hull()
            {
                translate([0,0,thickness/2+nothing])
                cube([length-2*thickness, width-2*thickness, thickness], center=true);
                translate([0,0,-drain_h+fillet])
                cylinder(d=drain_d, h=drain_h);
            }
            
            cylinder(h=2*thickness+2, d=drain_d, center=true);
            
        }
        
        intersection()
        {
            for (i=[l/3.3,0,-l/3.3], j=[-w/4.4,w/4.4])
            translate([i,j,-bump_r+t])
            sphere(r=bump_r);
            
            cube([l, w, 2*t], center=true);
        }
    }
}

translate([0,0,-80])
attachment_to_shower(max_d=59.5, min_d=55, h=80, drain_d=3, drain_h=10, fillet=3, wt=wt, contact_d=59);

translate([-85,-5,-100])
cup_holder(d=80+2*wt, h=100, drain_d=3, drain_h=10, fillet=3, wt=wt);

translate([90,0,0])
!soap_holder(length=80, width=50, thickness=5, drain_d=3, drain_h=3, fillet=1, bump_r=4, wt=wt);