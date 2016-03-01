include<../parts/servoHolder.scad>
include<../parts/lipoBattHolder.scad>

baseChassisX=130;
baseChassisY=basicBattHolderLength;
platesThickness=1;

battHolderDistFromServoFixation=29;

freeWheelHolesDistA=30;
freeWheelHolesDistB=25;
freeWheelChassisHolesRadius=3/2;

fixationScrewsRadius=3/2;

lateralHolesDepth=12+1;

freeWheelDistFromEdgeX=20;
freeWheelDistFromEdgeY=(baseChassisY-freeWheelHolesDistA)/2;
freeWheelZ=37;

freeWheelReinforcementBeamThickness=5;
freeWheelReinforcementBeamZ=5;

servoDecalFromEdge=20;
servoBatterySpacing=5;

stage1Height=22;

servoWheelsTyreThickness=2;
servoWheelsRadius=freeWheelZ-servoWheelsTyreThickness;
servoWheelWidth=8;
servoWheelRimThickness=2.5;
servoWheelCentralHubRadius=25/2;
servoWheelCentralHubLip=2;
servoWheelCentralHubHoleRadius=7/2;
servoWheelRimBarsThickness=2;
servoWheelRimBarsWidth=4;
servoWheelRimBarsLength=servoWheelsRadius-servoWheelCentralHubRadius-servoWheelRimThickness;
servoWheelFixHolesDistFromCenter=8.5;
servoWheelFixHolesRadius=2/2;



contactSwitchScrew1DecalY=24.5;
contactSwitchScrew2DecalX=12.8;
contactSwitchScrewDecal2=2.7;
contactSwitchScrewsRadius=3/2;


sensorsFixationBeamsSpacing=15;

backVerticalBeamsDecalY=5;


module servoWheelRimBar()
{
translate([servoWheelCentralHubRadius,-servoWheelRimBarsWidth/2,0])
cube([servoWheelRimBarsLength,servoWheelRimBarsWidth,servoWheelRimBarsThickness]);
    
translate([servoWheelCentralHubRadius-1,-1/2,0])
cube([servoWheelRimBarsLength+1,1,servoWheelWidth]);
}

module servoWheel()
{
difference()
{
    cylinder(r=servoWheelsRadius,h=servoWheelWidth,$fn=128);
    
    translate([0,0,-1])
    cylinder(r=servoWheelsRadius-servoWheelRimThickness,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    union()
    {
    cylinder(r=servoWheelCentralHubRadius,h=servoWheelWidth,$fn=128);
        cylinder(r=servoWheelCentralHubRadius+servoWheelCentralHubLip,h=servoWheelRimBarsThickness,$fn=128);
    }
    translate([0,0,-1])
        cylinder(r=servoWheelCentralHubHoleRadius,h=  servoWheelWidth*2,$fn=128);  
    
    for(i = [0 : 1 : 4])
    {
    angle01=90*i;
    rotate([0,0,angle01])
        translate([servoWheelFixHolesDistFromCenter,0,-1])
        cylinder(r=servoWheelFixHolesRadius,h=  servoWheelWidth*2,$fn=8);
    
    }
}
barsCount01=5;
rotationAngle01=360/barsCount01;

for(i = [0 : 1 : barsCount01])
{
    angle01=rotationAngle01*i;
    rotate([0,0,angle01])
        servoWheelRimBar();
    
}
}

//servoWheel();

servoTyreRadius=servoWheelsRadius*97/100;

module servoWheelTyre()
{
difference()
{
    cylinder(r=servoTyreRadius,h=servoWheelWidth,$fn=128);
    
    translate([0,0,-1])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    translate([0,0,-1])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-2])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}

difference()
{
    translate([0,0,servoWheelWidth])
    cylinder(r=servoTyreRadius,h=1,$fn=128);
    translate([0,0,-1])
    cylinder(r=servoTyreRadius-servoWheelsTyreThickness-2,h=servoWheelWidth*2,$fn=128);
}

gripBars=81;
rotationAngle01=360/gripBars;
for(i = [0 : 1 : gripBars])
{
    angle01=rotationAngle01*i;
    rotate([0,0,angle01])
        translate([servoTyreRadius-0.5,0,-1])
        cube([1.5,1,servoWheelWidth+2]);
    
}
}

//servoWheelTyre();

module fixationPillar(pillarWidth=freeWheelReinforcementBeamThickness,pillarHeight=stage1Height,pillarScrewRadius=fixationScrewsRadius)
{
    difference()
    {
    cube([pillarWidth,pillarWidth,pillarHeight]);
        translate([pillarWidth/2,pillarWidth/2,1])
        cylinder(r=pillarScrewRadius,h=pillarHeight,$fn=12);
    }
    
}

module basicChassis()
{
    cube([baseChassisX,baseChassisY,platesThickness]);
    
    
    
    fixationPillar();
    translate([0,baseChassisY-freeWheelReinforcementBeamThickness,0])
    fixationPillar();
    
    
    cube([servoDecalFromEdge,platesThickness,stage1Height]);
    
    translate([0,baseChassisY-platesThickness,0])
    cube([servoDecalFromEdge,platesThickness,stage1Height]);
    
    translate([servoHolderLength+servoDecalFromEdge+basicBattHolderWidth+servoBatterySpacing,baseChassisY-freeWheelReinforcementBeamThickness,0])
    fixationPillar();
    
    translate([servoHolderLength+servoDecalFromEdge+basicBattHolderWidth+servoBatterySpacing, 0,0])
    fixationPillar();
    
    translate([servoDecalFromEdge, 0,servoHolderZ])
    fixationPillar(freeWheelReinforcementBeamThickness,stage1Height-servoHolderZ,fixationScrewsRadius);
    
    translate([servoHolderLength+servoDecalFromEdge-freeWheelReinforcementBeamThickness, 0,servoHolderZ])
    fixationPillar(freeWheelReinforcementBeamThickness,stage1Height-servoHolderZ,fixationScrewsRadius);
    
    translate([servoDecalFromEdge, baseChassisY-freeWheelReinforcementBeamThickness,servoHolderZ])
    fixationPillar(freeWheelReinforcementBeamThickness,stage1Height-servoHolderZ,fixationScrewsRadius);
    
    translate([servoHolderLength+servoDecalFromEdge-freeWheelReinforcementBeamThickness, baseChassisY-freeWheelReinforcementBeamThickness,servoHolderZ])
    fixationPillar(freeWheelReinforcementBeamThickness,stage1Height-servoHolderZ,fixationScrewsRadius);

translate([servoHolderLength+servoDecalFromEdge,0,0])
rotate([0,0,90])
servoFixationServoHoles();

translate([servoDecalFromEdge,baseChassisY,0])
rotate([0,0,270])
servoFixationServoHoles();



/*
//disposition1
translate([10,battHolderDistFromServoFixation,0])
basicBattHolder();

translate([10,baseChassisY-basicBattHolderWidth-battHolderDistFromServoFixation,0])
basicBattHolder();
*/

/*
//disposition2
translate([servoHolderLength+4,0,0])
basicBattHolder();

translate([servoHolderLength+4,baseChassisY-basicBattHolderWidth,0])
basicBattHolder();
*/


/*
//disposition3
translate([basicBattHolderWidth+servoHolderLength+5,0,0])
rotate([0,0,90])
basicBattHolder();

translate([basicBattHolderWidth*2+servoHolderLength+5,0,0])
rotate([0,0,90])
basicBattHolder();*/

//disposition4
translate([basicBattHolderWidth+servoHolderLength+servoBatterySpacing+servoDecalFromEdge,0,0])
rotate([0,0,90])
basicBattHolder();



//free wheel reinforcement beams
translate([basicBattHolderWidth + servoHolderLength + servoBatterySpacing + servoDecalFromEdge, freeWheelDistFromEdgeY - freeWheelReinforcementBeamThickness/2, 0])
cube([baseChassisX - basicBattHolderWidth - servoHolderLength - servoBatterySpacing - servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

translate([basicBattHolderWidth + servoHolderLength + servoBatterySpacing + servoDecalFromEdge, baseChassisY -freeWheelDistFromEdgeY - freeWheelReinforcementBeamThickness/2,0])
cube([baseChassisX - basicBattHolderWidth - servoHolderLength - servoBatterySpacing - servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);


//front beams
//left
translate([basicBattHolderWidth + servoHolderLength + servoBatterySpacing + servoDecalFromEdge, 0, 0])
cube([baseChassisX - basicBattHolderWidth - servoHolderLength - servoBatterySpacing - servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

//right
translate([basicBattHolderWidth + servoHolderLength + servoBatterySpacing + servoDecalFromEdge, baseChassisY - freeWheelReinforcementBeamThickness,0])
cube([baseChassisX - basicBattHolderWidth - servoHolderLength - servoBatterySpacing - servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

//front
translate([baseChassisX - freeWheelReinforcementBeamThickness, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);



//sensors fixation beams
translate([baseChassisX - freeWheelReinforcementBeamThickness- sensorsFixationBeamsSpacing, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);

translate([baseChassisX - freeWheelReinforcementBeamThickness- sensorsFixationBeamsSpacing*2, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);

translate([baseChassisX - freeWheelReinforcementBeamThickness- sensorsFixationBeamsSpacing*3-1, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);






//back reinforcement bars
translate([0, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);


translate([servoDecalFromEdge-freeWheelReinforcementBeamThickness, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);


translate([servoDecalFromEdge +servoHolderLength, 0,0])
cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);

translate([0, 0, 0])
cube([servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

translate([0, freeWheelReinforcementBeamThickness, 0])
cube([servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

translate([0, baseChassisY - freeWheelReinforcementBeamThickness,0])
cube([servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

translate([0, baseChassisY - freeWheelReinforcementBeamThickness*2,0])
cube([servoDecalFromEdge, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

//back vertical (along X axis) central bars

translate([0, servoBodyY + backVerticalBeamsDecalY,0])
cube([servoDecalFromEdge+servoHolderLength, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);

translate([0, baseChassisY-servoBodyY-backVerticalBeamsDecalY-freeWheelReinforcementBeamThickness,0])
cube([servoDecalFromEdge + servoHolderLength,  freeWheelReinforcementBeamThickness,  freeWheelReinforcementBeamZ]);


//side walls
    translate([servoDecalFromEdge+servoHolderLength, 0, 0])
    cube([baseChassisX - servoDecalFromEdge-  servoHolderLength - servoBatterySpacing -  contactSwitchScrew2DecalX,platesThickness,stage1Height]);
    
    translate([servoDecalFromEdge+servoHolderLength,baseChassisY-platesThickness,0])
    cube([baseChassisX - servoDecalFromEdge-  servoHolderLength - servoBatterySpacing -  contactSwitchScrew2DecalX,platesThickness,stage1Height]);
/*
translate([servoDecalFromEdge+servoHolderLength, 0, 0])
cube([servoBatterySpacing*2, platesThickness, servoBodyZ+2]);

translate([servoDecalFromEdge+servoHolderLength, baseChassisY - platesThickness,0])
cube([servoBatterySpacing, platesThickness, servoBodyZ+2]);
*/
}


module freeWheelsFixationHoles(holesZ=freeWheelReinforcementBeamZ*4)
{
    
translate([baseChassisX - freeWheelDistFromEdgeX, freeWheelDistFromEdgeY , -1])
cylinder(r=freeWheelChassisHolesRadius,h=holesZ,$fn=12);

translate([baseChassisX - freeWheelDistFromEdgeX-freeWheelHolesDistB, freeWheelDistFromEdgeY , -1])
cylinder(r=freeWheelChassisHolesRadius,h=holesZ,$fn=12);


translate([baseChassisX - freeWheelDistFromEdgeX, freeWheelDistFromEdgeY + freeWheelHolesDistA , -1])
cylinder(r=freeWheelChassisHolesRadius,h=holesZ,$fn=12);

translate([baseChassisX - freeWheelDistFromEdgeX-freeWheelHolesDistB, freeWheelDistFromEdgeY + freeWheelHolesDistA, -1])
cylinder(r=freeWheelChassisHolesRadius,h=holesZ,$fn=12);
}


sensorsBlockDistY=32;
gridHolesDistFromEdgeY=15;
module chassisWithHoles()
{
difference()
{
    basicChassis();
    freeWheelsFixationHoles();
    
    //right switch
    translate([baseChassisX-contactSwitchScrew2DecalX,contactSwitchScrewDecal2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2,contactSwitchScrew1DecalY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    //left switch
    translate([baseChassisX-contactSwitchScrew2DecalX,baseChassisY-contactSwitchScrewDecal2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2,baseChassisY-contactSwitchScrew1DecalY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    //sensors block fixation holes
    translate([baseChassisX-contactSwitchScrewDecal2,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-freeWheelReinforcementBeamThickness/2,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-freeWheelReinforcementBeamThickness/2,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    //------------------
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    //------------
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    //------------
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    
    //back part holes
    /*translate([freeWheelReinforcementBeamZ/2,baseChassisY- servoBodyY-backVerticalBeamsDecalY-freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([freeWheelReinforcementBeamZ/2,servoBodyY + backVerticalBeamsDecalY+freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);*/
    
     translate([freeWheelReinforcementBeamZ/2,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([freeWheelReinforcementBeamZ/2,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    //-------
    translate([servoDecalFromEdge-freeWheelReinforcementBeamZ/2,baseChassisY- servoBodyY-backVerticalBeamsDecalY-freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge-freeWheelReinforcementBeamZ/2,servoBodyY + backVerticalBeamsDecalY+freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge-freeWheelReinforcementBeamZ/2,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge-freeWheelReinforcementBeamZ/2,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    //---------
    translate([servoDecalFromEdge+servoHolderLength+freeWheelReinforcementBeamZ/2,baseChassisY- servoBodyY-backVerticalBeamsDecalY-freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge+ servoHolderLength +freeWheelReinforcementBeamZ/2,servoBodyY + backVerticalBeamsDecalY+freeWheelReinforcementBeamZ/2,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge+servoHolderLength+freeWheelReinforcementBeamZ/2,baseChassisY- gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([servoDecalFromEdge+ servoHolderLength +freeWheelReinforcementBeamZ/2,gridHolesDistFromEdgeY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    //right switch back
    translate([contactSwitchScrew2DecalX,contactSwitchScrewDecal2+freeWheelReinforcementBeamThickness,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([contactSwitchScrewDecal2,contactSwitchScrew1DecalY+freeWheelReinforcementBeamThickness,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    //left switch back
    translate([contactSwitchScrew2DecalX,baseChassisY-contactSwitchScrewDecal2-freeWheelReinforcementBeamThickness,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([contactSwitchScrewDecal2,baseChassisY-contactSwitchScrew1DecalY-freeWheelReinforcementBeamThickness,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    
    
    //lateral holes on the chassis base LEFT
    translate([freeWheelReinforcementBeamThickness/2,-1,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge-freeWheelReinforcementBeamThickness/2,-1,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness/2+servoHolderLength,-1,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness+servoHolderLength+basicBattHolderWidth+1,-1,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness*1.5+servoHolderLength+basicBattHolderWidth+sensorsFixationBeamsSpacing,-1,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    
    //lateral holes on the chassis base RIGHT
    translate([freeWheelReinforcementBeamThickness/2,baseChassisY+1-lateralHolesDepth,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge-freeWheelReinforcementBeamThickness/2,baseChassisY+1-lateralHolesDepth,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness/2+servoHolderLength,baseChassisY + 1 -lateralHolesDepth, freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness+servoHolderLength+basicBattHolderWidth + 1,baseChassisY+1-lateralHolesDepth,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
    
    translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness*1.5+servoHolderLength+basicBattHolderWidth+sensorsFixationBeamsSpacing,baseChassisY+1-lateralHolesDepth,freeWheelReinforcementBeamZ/2])
    rotate([-90,0,0])
    cylinder(r=fixationScrewsRadius,h=lateralHolesDepth,$fn=16);
}
}

module sensorServoSupport()
{
difference()
    {
union()
    {
translate([80,48.5,4.5])
{
rotate([0,0,-90])
servoFixationVerticalServoHoles();
    
 
}
translate([113.3,28.5,5])   
cube([2,25,1]);
}

    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);

   translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*2,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);

    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,baseChassisY-sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
    
    translate([baseChassisX-contactSwitchScrewDecal2-sensorsFixationBeamsSpacing*3,sensorsBlockDistY,-1])
    cylinder(r=contactSwitchScrewsRadius,h=freeWheelReinforcementBeamZ*2,$fn=16);
}
}

module sensorServoSupportPrintReady()
{
    rotate([-180,0,0])
sensorServoSupport();
}








beamsThickness=2.0;
circuit1X=50;
circuit1Y=70;
circuit1ScrewsRadius=2/2;
circuit1ScrewsDistFromEdge=1;
circuit1ScrewPillarsH=5+beamsThickness;
screwHolesRadius=2/2;
padding=0.1;

module openBasePlate(x,y,nbBeamsX=3,nbBeamsY=2)
{
	xShift=x/(nbBeamsX+1);
	for (i =[0:nbBeamsX+1])
	{
		translate([xShift*i,0,0])
			cube([beamsThickness,y,beamsThickness]);
	}


	yShift=y/(nbBeamsY+1);
	for (i =[0:nbBeamsY+1])
	{
		translate([0,yShift*i,0])
			cube([x+beamsThickness,beamsThickness,beamsThickness]);
	}
}
module circuit1Plate()
{

	openBasePlate(circuit1X,circuit1Y,0,0);

	translate([beamsThickness+circuit1ScrewsDistFromEdge,beamsThickness+circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([beamsThickness+circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([circuit1X-circuit1ScrewsDistFromEdge,beamsThickness+circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}

	translate([circuit1X-circuit1ScrewsDistFromEdge,circuit1Y-circuit1ScrewsDistFromEdge,0])
		difference()
		{
			cylinder(r=beamsThickness,h=circuit1ScrewPillarsH,$fn=32);
			motorBracketHole();
		}		
}

module motorBracketHole(h0=10,shift=beamsThickness,r0=screwHolesRadius) 
{
	translate([0,0,padding+shift]) 
	{
    	cylinder(r=r0, h0+padding, center = false,$fn=32);
	}
}

module electronicsPlate()
{
translate([0,0,22])
{
    difference()
    {
        union()
        {
            translate([0, 0,0])
            cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);


            translate([servoDecalFromEdge-freeWheelReinforcementBeamThickness+10, 0,0])
            cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);


            translate([servoDecalFromEdge +servoHolderLength-freeWheelReinforcementBeamThickness-2, 0,0])
            cube([freeWheelReinforcementBeamThickness,baseChassisY , freeWheelReinforcementBeamZ]);

            translate([0, 0, 0])
            cube([servoDecalFromEdge+servoHolderLength, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);


            translate([0, baseChassisY - freeWheelReinforcementBeamThickness,0])
            cube([servoDecalFromEdge+servoHolderLength, freeWheelReinforcementBeamThickness, freeWheelReinforcementBeamZ]);
        }
        
        //back holes
        translate([freeWheelReinforcementBeamThickness/2, freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        translate([freeWheelReinforcementBeamThickness/2, baseChassisY-freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        //middle holes
        translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness/2, freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        translate([servoDecalFromEdge+freeWheelReinforcementBeamThickness/2, baseChassisY-freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        //front holes
         translate([servoDecalFromEdge+servoHolderLength-freeWheelReinforcementBeamThickness/2, freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        translate([servoDecalFromEdge+servoHolderLength-freeWheelReinforcementBeamThickness/2, baseChassisY-freeWheelReinforcementBeamThickness/2,-freeWheelReinforcementBeamZ])
        cylinder(r=fixationScrewsRadius,h=freeWheelReinforcementBeamZ*3,$fn=12);
        
        
    }
    
    translate([0,(baseChassisY-circuit1Y)/2-freeWheelReinforcementBeamThickness/5,freeWheelReinforcementBeamZ-2])
    circuit1Plate(circuit1X,circuit1Y,0,0);
}

}








//sensorServoSupportPrintReady();


//chassisWithHoles();
electronicsPlate();








