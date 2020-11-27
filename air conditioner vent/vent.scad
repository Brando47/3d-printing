use <snap_fit.scad>

union()
{
    
    hook(a2=1.5, a3=4.5, b2=12, b1=3, b3=2.4);
    
    translate([0,9.2,0])
    mirror([0,1,0])
    hook(a2=1.5, a3=4.5, b2=12, b1=3, b3=2.4);
    
    translate([0,2.5,0])
    rotate([90,0,180])
    hook(b4=4.2, b1=2.5, b5=9.2, b3=2.5, a1=0, a4=90, a5=13.5, a2=0.6, a3=2.5);
    
    translate([-13,0,0])
    cube([5,9.2,2.5]);
    translate([-8,0,0])
    cube([8,2.5,2.5]);
    translate([-8,6.7,0])
    cube([8,2.5,2.5]);
    
}
