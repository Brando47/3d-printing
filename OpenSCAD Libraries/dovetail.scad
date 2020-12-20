use <fillets.scad>;
$fn=50;

module dovetail(thin_w=4, thick_w=8, l=6, h=2.5, female=false, clearance=0.3, fillets=true, fillet_radius=0.5)
{
    nothing=0.001; //combats rounding errors leading to non-manifold mesh
    if (female == false)
    {
        difference()
        {
            union()
            {
                linear_extrude(h)
                polygon([
                    [-thin_w/2, 0],
                    [thin_w/2, 0],
                    [thick_w/2, -l],
                    [-thick_w/2, -l]
                ]);
                
                if (fillets)
                {
                    theta=atan(l/(thick_w/2 - thin_w/2));
                    for (i = [-1,1]) {
                    
                        translate([i*(thin_w/2-nothing),nothing,0])
                        rotate([0,0,45-i*(90+theta/2)])
                        fillet(l=h, r=fillet_radius, a=theta, center=false);
                        
                    }
                }
            }
            
            if (fillets)
            {
                
                theta=atan(l/(thick_w/2 - thin_w/2));
                for (i = [-1,1]) {
                    
                    translate([i*(thick_w/2+nothing),-l-nothing,-1])
                    rotate([0,0,45+i*(180-theta)/2])
                    fillet(l=h+2, r=fillet_radius, a=theta, center=false);
                    
                }
                
            }
            
        }
    }
    else
    {
        theta=atan(l/(thick_w/2 - thin_w/2));
        a=clearance/sin(theta);
        b=(l+clearance)*((thick_w/2 - thin_w/2)/l);
        
        pullout_distance=a*(l/(thick_w/2 - thin_w/2));
        echo(str("Dovetail axial clearance is ", pullout_distance, "mm"));
        
        difference()
        {
            union()
            {
                
                linear_extrude(h)
                polygon([
                    [-thin_w/2 - a, 0],
                    [thin_w/2 + a, 0],
                    [a + thin_w/2 + b, -l - clearance],
                    [-(a + thin_w/2 + b), -l - clearance]
                ]);
                
                //add top fillets
                if (fillets)
                {
                    for (i = [-1,1]) {
                        
                        translate([i*(a+thin_w/2-nothing),nothing,0])
                        rotate([0,0,45-i*(90+theta/2)])
                        fillet(l=h, r=fillet_radius, a=theta, center=false);
                    }
                }
            }
            
            //remove bottom fillets
            if (fillets)
            {
                for (i = [-1,1]) {
                    
                    translate([i*(a+thin_w/2+b+nothing),-l-clearance-nothing,-1])
                    rotate([0,0,45+i*(180-theta)/2])
                    fillet(l=h+2, r=fillet_radius, a=theta, center=false);
                    
                }
            }
            
        }
    }
    
}

%translate([0,0,-1])
dovetail(female=true);

dovetail(female=false);
