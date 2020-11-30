//mirrors an object at a plane through a point

module mirror_offset(v, p=[0,0,0], duplicate=false)
{
    
    mirror(v)
    translate(-2*p)
    children();
    
    if(duplicate){ children(); }
    
}
