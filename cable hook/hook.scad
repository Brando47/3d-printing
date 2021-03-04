
$fn=40;

w=10;
wt=2;
bottom=1;
top=2;
lip=0.5;

inner_h=12;
inner_t=2.4;

r=0.5;

total_height=top+bottom+inner_h;
echo(total_height=total_height);


module side_profile()
{
    
    offset(r=r)
    offset(r=-2*r)
    offset(r=r)
    polygon([
        [0, 0],
        [0, -wt],
        [total_height, -wt],
        [total_height, 0],
        [top+inner_h, 0],
        [top+inner_h, inner_t+wt],
        [top, inner_t+wt],
        [top, inner_t-lip],
        [top+wt, inner_t-lip],
        [top+wt, inner_t],
        [top+inner_h-wt, inner_t],
        [top+inner_h-wt, 0]
    ]);
    
}


linear_extrude(w)
side_profile();
