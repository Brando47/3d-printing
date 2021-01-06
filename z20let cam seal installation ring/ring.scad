
$fn=100;

length=15;
inner_d=36;
outer_d=45;

difference()
{
    
    cylinder(h=length, d=outer_d);
    
    translate([0,0,-1])
    cylinder(h=length+2, d=inner_d);
    
}
