

servoBodyX=30;
servoBodyY=50;
servoBodyZ=20;
servoFixationLip=20;
servoFixationPlatesThickness=2;

servoHolderLength=servoFixationPlatesThickness*2+servoFixationLip*2;

module servoFixationNoHoles()
{
    
    sbX=servoBodyX;
    sbY=servoBodyY;
    sbZ=servoBodyZ;
    sfl=servoFixationLip;
    pThick=servoFixationPlatesThickness;
    
    
    
    
    cube([sbX+pThick,sbY+servoFixationPlatesThickness*2+2*sfl,pThick]);
    
    translate([0,0,pThick])
    cube([pThick,sfl,sbZ]);
    
    translate([0,sbY+pThick*2+sfl,pThick])
    cube([pThick,sfl,sbZ]);
    
    translate([0,0,pThick+sbZ])
    cube([pThick,sbY+servoFixationPlatesThickness*2+2*sfl,pThick]);
    
    translate([pThick,sfl-pThick,pThick])
    cube([sbX/2,pThick,sbZ]);
    
    translate([pThick,sbY+sfl+pThick*2,pThick])
    cube([sbX/2,pThick,sbZ]);
}


module servoFixationSerVoHoles()
{
    sbX=servoBodyX;
    sbY=servoBodyY;
    sbZ=servoBodyZ;
    sfl=servoFixationLip;
    pThick=servoFixationPlatesThickness;
    sHolesRadius=3/2;
    sHolesDistFromEdge=10;
    difference()
    {
        servoFixationNoHoles();
        
        
        translate([-pThick,sfl+pThick-sHolesDistFromEdge,pThick+servoBodyZ/2])
        rotate([0,90,0])
        {
            cylinder(r=sHolesRadius,h=pThick*3,$fn=12);
        }
        
        
        translate([-pThick,sfl+pThick*2+sbY+sHolesDistFromEdge,pThick+servoBodyZ/2])
        rotate([0,90,0])
        {
            cylinder(r=sHolesRadius,h=pThick*3,$fn=12);
        }
        
    }
}


servoFixationSerVoHoles();
