// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON = 1; 
#if (Radiosity_ON = 1 )
global_settings{
  ambient_light 1
  assumed_gamma 1.0
  radiosity {
         // pretrace_start 1
         // pretrace_end 1
          //adc_bailout 2
          error_bound 0.6
          count 30
          brightness 0.55
          gray_threshold 0.25
         // media on
         normal on
          recursion_limit 2
       } // --------------
 }// end global_settings
#else
global_settings{ assumed_gamma 1.1 }
#default{ finish{ ambient 0.2 diffuse 0.9 }}
#end
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
//#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "Chair_s00.inc"
//#include "shapes.inc"
#include "shapes3.inc"
#include "Roof_0.inc"
#include "basis.inc"
#declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
#declare Camera_1 = camera {perspective angle 90   // rueckseite
                            location  <-20 ,15.0 ,10.0>
                            look_at   <0 ,15,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <130 ,15 ,-60>
                            right x*image_width/image_height
							look_at <0,15,-60>
							}
#declare Camera_3 = camera { perspective angle 90//links
                            location  <-40 , 20 ,-80>
                            right x*image_width/image_height
							look_at <0,10,-70>
							}

#declare Camera_4 = camera {perspective angle 90        // oben
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location  <50 , 5.0 ,-150>
                            right x*image_width/image_height
							look_at <50,8,0>}
camera {Camera_0}

// sun -------------------------------------------------------------------
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >}  // sunlight
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
light_source{ <25, 35 ,15>color White*0.9 shadowless} // flash 2
sky_sphere{
 pigment{ gradient <0,1,0>
          color_map{
          [0.0 color rgb<1,1,1>        ]
          [0.8 color rgb<0.1,0.25,0.75>]
          [1.0 color rgb<0.1,0.25,0.75>]}
        } // end pigment
 }
 
plane { <0,1,0>, 0

        texture{ pigment{ color DarkGreen}
	         normal { bumps 0.25 scale 0.05 }
             
               }
          translate<0,-50,0>
      }
#end
//=============================================objekte
#declare BT = texture {pigment {color rgb 0.2}}
#declare TTrans = texture {pigment{color Clear}}
#declare BalkonPfosten = texture_map{[0.0 T_Wood12][0.6 T_Wood26][0.7 T_Wood12][0.7 TTrans][0.9 BT][1.0 BT]}
#declare HT = texture {pigment {color DarkSlateBlue}}
#declare Wand_Farbe_1 =
texture{ pigment{ color rgb <0.5,0.09,0.09>}
         normal {bozo 0.8 turbulence 0.5 scale 1.2}}
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}


#declare RoofTrans = <-2.35,0,0>;
#declare Roof_Base_Color = <0.69,0,0.16>;
#declare Roof_Color_Factor = 0.4;
//Dachtextur
#declare Roof_Texture1 = texture{
   pigment{gradient x 
           color_map{[0.00 color Scarlet*0.7 ]
                     [0.90 color Scarlet*0.6 ]
                     [0.90 color rgb 0.1 ]
                     [0.95 color rgb 0 ]
                     [1.00 color rgb 0 ]
                    }
           scale 4}
   normal { bumps 0.3 scale 0.015} 
   finish { specular 0.08 roughness 0.8}
   translate RoofTrans}

#declare Roof_Texture2 = texture{
   Roof_Texture1 
   finish { ambient 0.15 diffuse 0.85}}
#declare T_Wood_Door = texture{pigment{P_WoodGrain1A color_map {
    [0.000, 0.256 color rgb <0.30,0.65,1>*1.25 
                  color rgb <0.30,0.65,1>*1.25]
    [0.256, 0.393 color rgb <0.30,0.65,1>*1.25
                  color rgb <0.23,0.49,0.75>*1.25]
    [0.393, 0.581 color rgb <0.23,0.49,0.75>*1.25
                  color rgb <0.23,0.49,0.75>*1.25]
    [0.581, 0.726 color rgb <0.19,0.42,0.6>*1.25
                  color rgb <0.19,0.42,0.6>*1.25]
    [0.726, 0.983 color rgb <0.19,0.42,0.6>*1.25
                  color rgb <0.19,0.42,0.6>*1.25]
    [0.983, 1.000 color rgb <0.2,0.42,0.65>*1.25
                  color rgb <0.2,0.42,0.65>*1.25]
}}}
   //===========================================================
#declare Haus_Roh =
union{
difference {
box {<0,0,0>,<70,19.5,50>}       
//Abzug Dachflaechen
//Innenraum
box {<0.5,0.5,0.5>,<69.5,25,49.5> pigment{color MediumSeaGreen}}
//Fensteraussparungen EG
object {Fenster_AS_6x6 translate <10,6,-0.2>}
object {Fenster_AS_6x6 translate <25,6,-0.2>}
object {Fenster_AS_6x6 translate <40,6,-0.2>}
object {Fenster_AS_6x6 translate <55,6,-0.2>}
//Fensteraussparungen links
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,11>}
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,23>}

//Fensteraussparungen rechts
object {Fenster_AS_6x6 rotate y*90 translate <69.5,6,12>}
object {Fenster_AS_6x6 rotate y*90 translate <69.5,6,43>}
//Fensteraussparungen EG-R
object {Fenster_AS_6x6 translate <10,6,49.5>}
object {Fenster_AS_6x6 translate <25,6,49.5>}
object {Fenster_AS_6x6 translate <40,6,49.5>}
object {Fenster_AS_6x6 translate <55,6,49.5>}
//Haustuer
box {<0,0,0>,<9,11.5,1> rotate y*90 translate <-0.1,0.5,37>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
texture {Wand_Farbe_1}
 }
#declare WDR = difference{cylinder {<0,0,0>,<71,0,0>,0.4}cylinder {<0,0,0>,<70.5,0,0>,0.35 translate <0,0.2,0>} texture {T_Brass_1A}}
#declare SDR = cylinder {<0,0,0>,<0,19,0>,0.3 texture {T_Brass_1A}}

#declare Zaun_Saeule = union{box{<0,0,0>,<1.5,7.5,1.5> texture{T_Stone31 scale 0.7} texture{pigment{brick 
                White*0.2
                Clear
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}}
                }box{<-0.2,6.5,-0.2>,<1.7,6.6,1.7> texture{T_Stone31}
                }
                }
#declare Zaun_Pfosten = box{<-0.2,0,-0.1>,<0.2,6,0.1> texture {T_Wood12}}
#declare Zaun_Pfosten_Z = box{<-0.1,0,-0.2>,<0.1,6,0.2> texture {T_Wood12}}
#declare g_beet = union{difference{box {<0,0,0>,<8,1,18>}box {<0.2,0.5,0.2>,<7.8,1.5,17.8>} texture{T_Wood3 scale 0.4 rotate x*90}}box {<0.2,0.5,0.2>,<7.8,0.6,17.8>texture{ pigment{bozo turbulence 0.3 color_map{[0.0 color rgb <0.4,0.26,0.13>*0.5][0.5 color rgb <0.2,0.13,0.07>*0.2][1 color rgb <0.18,0.12,0.06>*0.5]} }normal { bozo 3 scale 0.05} finish { diffuse 0.9}}}
#declare Random_1 = seed (2655);
#declare Random_2 = seed (1153);
//--------------------------------
union{
 // outer loop -------------------
 #declare NrX = 0.5;  // start x
 #declare EndNrX =  3.5;// end   x
 #while (NrX< EndNrX+1)
  // inner loop ------------------
  #declare NrZ = 0.5;     // start z
  #declare EndNrZ =  8; // end   z
  #while (NrZ< EndNrZ+1)

  sphere{ <0,0,0>, 0.25
    texture{ pigment{color DarkGreen}
             finish {phong 0.3}
           } // end of texture
    translate < 2*NrX+1.5*(-0.5+rand(Random_1)),0.7,2*NrZ+1.5*(-0.5+rand(Random_2))>
  } // end of sphere --------------

  #declare NrZ = NrZ + 1; // next Nr z
  #end // -------------- end of loop z
  // end inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
// end of outer loop
}
   }
//Szene=============================================================================================================

union{
object {Haus_Roh translate <0,0,-115>}
//Fenster EG===========================================
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,5.4,0.05>}box{<0,0,-0.1>,<5,5,0.1>} pigment{color White*0.7}}
 translate <10,6,-115.1>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 translate <25,6,-115.1>}
 union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 translate <40,6,-115.1>}
 union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 translate <55,6,-115.1>}
 //Fenster EG-Rückseite
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*180 translate <16.5,6,-65>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*180 translate <31.5,6,-65>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*180 translate <46.5,6,-65>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*180 translate <61.5,6,-65>}

//Fenster EG-links
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*90 translate <0,6,-104>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*90 translate <0,6,-92>}
//Fenster EG-rechts
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*-90 translate <70,6,-109.5>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*-90 translate <70,6,-78.5>}

//Haustür
union{
difference{
box {<0,0,0.5>,<9,11.5,0.8> texture{T_Wood_Door  scale .8}}
box {<2.8,2,0.4>,<4.2,7,0.9> texture{NBoldglass}}
}
sphere {<0,0,0>,0.35 translate <0.4,3.5,0.5> texture{T_Copper_2A}}
cylinder{<0,0,0>,<1,0,0>,0.29 translate <0.3,3.5,0.5> texture{T_Brass_1A}}
box{<-0.5,11.5,-0.4>,<10.5,12,0> pigment{color NewTan*0.4}}
prism {0,9,4
        <0,0>,
        <0.7,0>,
        <0,.7>,
        <0,0> rotate x*-90 rotate y*90 translate <9,12,0>texture {T_Brass_1A}}
rotate y*90
translate <-0.3,0.5,-78>}
//Treppenstufen
union{
cylinder{<0,0,0>,<0,0.2,0>,5}
cylinder{<0,0,0>,<0,0.29,0>,4 translate<0,0.2,0>}
texture {T_Grnt25 scale 0.7 normal{pigment_pattern{ brick
                     color rgb 0.2,
                     color rgb 0.8
                     scale 0.8}}}
translate <0,0,-82>}
object{ Segment_of_Torus( 1,
                          0.6,
                          90
                        ) //------------
        texture{T_Brass_1A}
        scale<1,1,1>
        rotate<-90,0,0>
        rotate<-0,120,0>
        translate<0.5,14,-114.8>
      }
//Dachflaechen
object{ Roof_0 (   45,    // Roof___Angle1, // roof angle                              
                    70.00, // Roof___WideX,  //   base length of the roof part in x-direction
                    50.00, // Roof___WideZ,  //   base length of the roof part in z-direction  
                   1.0,  // Roof___Over,     // overhang
                   1.1, // R_Cyl,          // radius cylinders
                   1.4,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //------------------------------------------------------  
 scale <1,0.7,1>       
translate<-0,19.5,-115>}
//====KLEINKRAM

object{ Chair_s00 ( 0.80, // Total_Chair_Height, 
                    0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //---------------------------- 
        texture{ T_Wood6 scale 0.05 } 
        scale 4 rotate<0,180,0> translate< 10,0.00,-62>
      } 
object{ Chair_s00 ( 0.80, // Total_Chair_Height, 
                    0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //---------------------------- 
        texture{ T_Wood6 scale 0.05 } 
        scale 4 rotate<0,180,0> translate< 4,0.00,-62>
      }
object{ Chair_s00 ( 0.80, // Total_Chair_Height, 
                    0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //---------------------------- 
        texture{ T_Wood6 scale 0.05 } 
        scale 4 translate< 9,0.00,-55>
      }
object{ Chair_s00 ( 0.80, // Total_Chair_Height, 
                    0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //---------------------------- 
        texture{ T_Wood6 scale 0.05 } 
        scale 4 translate<5,0.00,-55>
      }
object {Table(9,2.5,6,0.2,0.2) translate<6,0.5,-58> texture{T_Wood28 scale 0.8}}
//Dachrinnen
object{WDR translate<-0.5,19,-116>}
object{WDR translate<0,19,-64>}
object{SDR translate<-0.3,0,-115.7>}
object{SDR translate<70.3,0,-64.7>}
//Kamin
object {Kamin_1 translate<19,21,-102>}
object {Kamin_1 translate<29,25,-86>}
//Brunnen=============================
object{Brunnen translate <55,-5,-30>}
//Ein Schuppen=============================
union{
difference{
box{<-10,0,-20>,<30,8,-30>}
box{<-11,8,-19.5>,<31,11,-32> rotate x*7 translate <0,-5,0>}
 texture{gradient x texture_map{BalkonPfosten}}}
box{<-10.5,8,-19.5>,<30.5,8.4,-32> rotate x*7 translate <0,-5,0> texture{gradient x texture_map{
[0.0 T_Wood2][0.7 T_Wood2][0.7 T_Wood15][0.9 BT][1.0 BT]}}}
}
//Gemüsebeete

object {g_beet translate<74,-0.1,-60>}
object {g_beet translate<80,-0.1,-80>}
object {g_beet translate<80,-0.1,-100>}
//Mauer======================================================
union{
box { <-20,0,-134>,<-19,7,-15>texture{pigment{ image_map { png "dirtwall.png" map_type 0 interpolate 2} scale 7 rotate y*90}}}
box { <0,0,-134>,<100,7,-133>texture{pigment{ image_map { png "dirtwall.png" map_type 0 interpolate 2} scale 7}}}
box { <99,0,-134>,<100,7,-15>texture{pigment{ image_map { png "dirtwall.png" map_type 0 interpolate 2} scale 7 rotate y*90}}}
box { <-20,0,-14>,<100,7,-15>texture{pigment{ image_map { png "dirtwall.png" map_type 0 interpolate 2} scale 7}}}
}
object{Zaun_Saeule translate<-20,0,-134>}//linksvorne
object{Zaun_Saeule translate<0,0,-134>}//linksvorne Pfosten

//Asphalt in der Einfahrt

box {<-19.8,-0.1,-15.8>,<0,0.05,-134> texture{pigment{ crackle scale 1.5 turbulence 0.35
         color_map { [0.00 color rgb 0.33*0.2]
                     [0.08 color rgb 0.35*0.5]
                     [0.32 color rgb 0.2]
                     [1.00 color rgb 0.4]
                   } // end of color_map
         scale 0.2}
         normal{crackle scale 1.5 turbulence 0.35}}
    }
box {<-19.8,-0.1,-18>,<62,0.05,-65> texture{pigment{ crackle scale 1.5 turbulence 0.35
         color_map { [0.00 color rgb 0.33*0.2]
                     [0.08 color rgb 0.35*0.5]
                     [0.32 color rgb 0.2]
                     [1.00 color rgb 0.4]
                   } // end of color_map
         scale 0.2}
         normal{crackle scale 1.5 turbulence 0.35}}
    }

       
//Bäume

#include "birke.inc"

#declare LEAVES=400*BUNCHES;
#declare BOTTOM_COLOR_1=<0.3,0.4,0,0,0>;
#declare BOTTOM_COLOR_2=<0.4,0.5,0,0,0>;
#declare TOP_COLOR_1=<0.3, 0.5,0,0,0>;
#declare TOP_COLOR_2=<0.3, 0.6,0,0,0>;


#declare SUNKEN_TRUNK_COLOR=<1,1,1>*1.3;
#declare RAISED_TRUNK_COLOR=<1,1,1>*1.3;
#declare FOLIAGE_COLOR_AT_BRANCH_END=0;



#include "TOMTREE-1.5.inc"
#declare Tree_01 = object{ TREE double_illuminate hollow}

object{ Tree_01 scale 3.3 rotate< 0, 45, 0> translate< 18,-1, -110>}
object{ Tree_01 scale 3.3 rotate< 0, 45, 0> translate< 18,-1, -120>}
object{ Tree_01 scale 3.3 rotate< 0, 45, 0> translate< 18,-1, -125>}
object{ Tree_01 scale 3.3 rotate< 0, 45, 0> translate< 18,-1, -128>}
object{ Tree_01 scale 3.3 rotate< 0, 45, 0> translate< 18,-1, -130>}
object{ Tree_01  scale 30 rotate< 0, 45, 0> translate<67,0, -52>}
object{ Tree_01  scale 32 rotate< 0, 45, 0> translate <50,0,-120>}//<81,-1, -30>}


#declare RINDE = texture {
	pigment {
		granite
		cubic_wave
		color_map {
			[0 color rgb <0.35, 0.25, 0.17>]
			[0.35 color rgb <0.49019, 0.34117, 0.21176>]
			[0.5 color rgb <0.49019, 0.34117, 0.21176>*2]
			[0.65 color rgb <0.49019, 0.34117, 0.21176>]
			[1 color rgb <0.35, 0.25, 0.17>]
		}
		scale <1.0, 10.0, 1.0>*3
	}
	finish {
		phong -1.0/5 phong_size 4
	}
}
#declare RINDE1 = texture {
	pigment {
		granite
		cubic_wave
		color_map {
			[0 color rgb <0.35, 0.25, 0.17>]
			[0.35 color rgb <0.0, 1.2, 0.0>/4]
			[0.50 color rgb <0.0, 1.2, 0.0>/2]
			[0.65 color rgb <0.0, 1.2, 0.0>/4]
			[1 color rgb <0.35, 0.25, 0.17>]
		}
		scale <1.0, 10.0, 1.0>*3
	}
	finish {
		phong -1.0/5 phong_size 4
	}
}

//Sommer

#declare BOZO1 = pigment {
	bozo
	color_map {
		[0 color rgb<0.17, 0.58, 0.0>]
		[1 color rgb<0.17, 0.58, 0.0>]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgb<0.17, 0.58, 0.0>]
		[1 color rgb<0.17, 0.58, 0.0>]
	}
	scale 0.04
}

#declare LAUB = texture {
	pigment {
		gradient y
		cubic_wave
		turbulence 0.0
		omega 0.0
		pigment_map {
			[0.0 BOZO1]
			[1 BOZO2]
		}
		scale 1006.7368
	}
	finish {
		phong 0.4*0.0 phong_size 20*0.0
	}
}
#include "kirsche_wood.inc"
#include "kirsche_foliage.inc"

union {
object{FOLIAGE texture{LAUB}}

object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 20
translate <30,0,-125>
}

union {
object{FOLIAGE texture{LAUB}}

object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 20
translate <81,-1, -30>
}
union {
object{FOLIAGE texture{LAUB}}

object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 22
translate <80,0,-130>
}
union {
object{FOLIAGE texture{LAUB}}

object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 22
translate <92,0,-80>
}
//Bodenplatte
object {bodenplatte texture { pigment{ image_map { png "grass.png" map_type 0 interpolate 2}} rotate <90,0,0> scale 5 finish {ambient 0}}}

//Ende Bodenplatte

#declare Richtung = 3;
#switch ( Richtung )
#case (0)
//sued
#break
#case (3)//west
rotate <0,90,0>
translate <112,0,-28>
#break
#case (2)//nord
rotate <0,180,0>
translate <80,0,-145>
#break
#case (1)//ost
rotate <0,270,0>
translate <-35,0,-115>
#break
#end
//Ende der Szene
}
