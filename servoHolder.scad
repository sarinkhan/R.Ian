/**
 * Basic servo holder meant to be integrated elsewhere.
 * This should provide multiple modules later on with more
 * functionnalities and even modules for specific servomotors.
 */

servoBodyX=5;
servoBodyY=23.3;
servoBodyZ=12;
servoFixationLip=5;
servoFixationPlatesThickness=2;
sHolesDistFromEdge=3;

servoHolderLength=servoFixationPlatesThickness*2+servoFixationLip*2+servoBodyY;

module servoFixationNoHoles()
{
    
    sbX=servoBodyX;
    sbY=servoBodyY;
    sbZ=servoBodyZ;
    sfl=servoFixationLip;
    pThick=servoFixationPlatesThickness;
    
    
    
    
    cube([sbX+pThick,sbY+2*sfl,pThick]);
    
    translate([0,0,pThick])
    cube([pThick*2,sfl,sbZ]);
    
    translate([0,sbY+sfl,pThick])
    cube([pThick*2,sfl,sbZ]);
    
    /*translate([0,0,pThick+sbZ])
    cube([pThick,sbY+2*sfl,pThick]);
    */
    /*translate([pThick,0,pThick])
    cube([sbX/2,pThick,sbZ]);
    
    translate([pThick,sbY+sfl*2-pThick,pThick])
    cube([sbX/2,pThick,sbZ]);*/
}


module servoFixationSerVoHoles()
{
    sbX=servoBodyX;
    sbY=servoBodyY;
    sbZ=servoBodyZ;
    sfl=servoFixationLip;
    pThick=servoFixationPlatesThickness;
    sHolesRadius=2.5/2;
    sHolesDistEdge=sHolesDistFromEdge;
    
    difference()
    {
        servoFixationNoHoles();
        
        
        translate([-pThick,sHolesDistEdge,pThick+servoBodyZ/2])
        rotate([0,90,0])
        {
            cylinder(r=sHolesRadius,h=pThick*4,$fn=12);
        }
        
        
        translate([-pThick,sfl*2+sbY-sHolesDistEdge,pThick+servoBodyZ/2])
        rotate([0,90,0])
        {
            cylinder(r=sHolesRadius,h=pThick*4,$fn=12);
        }
        
    }
}


//servoFixationSerVoHoles();
