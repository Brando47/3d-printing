//Press fit on outer, clearance fit on inner

$fn=80;

difference()
{
    union()
    {
        cylinder(d1=12.5, d2=13, h=7.6);
        
        cylinder(d=16.4, h=1.4);
        
    }
    
    translate([0,0,-1])
    cylinder(d=8.35, h=10);
}
