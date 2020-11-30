
module hook (a1=1, a2=1, a3=2.5, a4=50, a5=50, b1=2, b2=5.5, b3=1.4, b4=2.5, b5=2)
{
    
    //total_length=b2 + a2/tan(a4) + a1 + a2/tan(a5);
    total_length=b2 + a3;
    echo(str("Hook Total Length is: ", total_length, "mm"));
    
    end_width=b4 - 2*(((b4 - b5)/2 / b2) * total_length);
    echo(str("Hook End Width is: ", end_width, "mm"));
    
    beam_taper=atan(((b4-end_width)/2) / total_length);
    echo(str("Hook Beam X Taper is: ", beam_taper, " degrees"));
    
//    translate([0, -b1/2, -b4/2]) //use to centre on origin
    difference()
    {
        
        linear_extrude(b4)
        polygon([   [0, 0], 
                    [0, b1], 
                    [b2, b1], 
                    [b2 + a2/tan(a4), b1 + a2], 
                    [b2 + a2/tan(a4) + a1, b1 + a2],
                    [total_length, b1 + a2 - tan(a5)*(a3 - a1 - a2/tan(a4))],
                    [total_length, b1 - b3] 
                ]);        
        
        rotate([0, -beam_taper, 0])
        translate([0, -1, -1.5*b4])
        cube([1.5*total_length, b1 + a2 + 2, 1.5*b4]);
        
        mirror([0,0,1])
        translate([0,0,-b4])
        rotate([0, -beam_taper, 0])
        translate([0, -1, -1.5*b4])
        cube([1.5*total_length, b1 + a2 + 2, 1.5*b4]);
        
    }
    
}

//hook();

module loop (c1=3, c2=5, c3=2, c4=1, d1=0.5, d2=1.5, d3=0.5, d4=0.5)
{
    
    clip_taper=atan((c3 - c4)/c2);
    echo(str("Clip Taper is: ", clip_taper, " degrees"));
    
//    translate([0, -c1/2, -c3/2]) //use to centre on origin
    difference()
    {
        
        cube([c2, c1, c3]);
        
        translate([c2 - d4 - d2, d3, -1])
        cube([d2, c1 - d1 - d3, c3 + 2]);
        
        rotate([0, -clip_taper, 0])
        translate([0, -1, -c3])
        cube([1.5*c2, c1 + 2, c3]);
        
    }
    
}

//loop();
