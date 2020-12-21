
module square_toroid(r=10, h=5, wt=5, a=360)
{
    
    rotate_extrude(angle=a)
    translate([r-wt,0,0])
    square([wt, h]);
    
}

module torus(r=10, r_body=2.5, a=360)
{
    
    rotate_extrude(angle=a)
    translate([r,0,0])
    circle(r_body);
    
}

//square_toroid($fn=100);

torus($fn=100);

