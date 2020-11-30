
module fillet(l=2, r=2, a=90, center=true, v=[1,1,0], p=[0,0,0])
{
    
    v_norm=[ v[0], -v[1], -v[2] ]/sqrt(v*v); //corrected axis of v and normalised
    rotation_vector=(v[1]==0 && v[2]==0) ? [0,0,1] : cross(v_norm, [1,0,0]); //takes into account edge case of parallel start and finish vectors resulting in zero vector for cross product
    rotation_angle=acos(v_norm*[1,0,0]);
    
    translate(p)
    rotate(a=rotation_angle, v=rotation_vector)
    translate([0, 0, center ? -l/2 : 0])
    rotate([0,0,-a/2])
    difference()
    {
        
        x2=r/tan(a/2);
        x1=x2*cos(a);
        y1=x2*sin(a);
        
        linear_extrude(l)
        polygon([ [0,0], [x2,0], [x1,y1] ]);
        
        translate([x2, r, -1])
        cylinder(r=r, h=l+2);
        
    }
    
}

//fillet($fn=50);


// l = longitudal length of the chamfer
// d = distance of the chamfer
// a = interior angle of the chamfer
// center = whether the chamfer is centered on the origin
// edge = the angle of the chamfer to the horizontal (x-y plane)
// v = a vector normal to the face of the chamfer
// p = the position of the chamfer
module chamfer(l=2, d=2, a=90, center=true, edge=0, v=[1,1,0], p=[0,0,0])
{
    
    x1=d*cos(a);
    y1=d*sin(a);
    
    v_norm=[ v[0], -v[1], -v[2] ]/sqrt(v*v); //corrected axis of v and normalised
    rotation_vector=(v[1]==0 && v[2]==0) ? [0,0,1] : cross(v_norm, [1,0,0]); //takes into account edge case of parallel start and finish vectors resulting in zero vector for cross product
    rotation_angle=acos(v_norm*[1,0,0]);
    
    translate(p)
    rotate(a=rotation_angle, v=rotation_vector)
    rotate([edge,0,0])
    translate([0, 0, center ? -l/2 : 0])
    rotate([0,0,-a/2])
    linear_extrude(l)
    polygon([ [0,0], [d,0], [x1,y1] ]);
    
}

//chamfer();
