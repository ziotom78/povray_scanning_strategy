// -*- mode: pov -*-
//
// POV-Ray scene file (tested with POV-Ray 3.7)
//
// August 2019
//
// Representation of the scanning strategy of the LiteBIRD spacecraft
//
// Note: the "clock" variable is supposed to track time in *minutes*

#include "colors.inc"

#declare bore_spin_angle = 50.0;
#declare spin_sun_angle = 45.0;
#declare prec_period_min = 192.348;
#declare spin_period_min = 20.0;

camera {
  // Put here the aspect ratio as it is in the file
  // litebird-scanning-strategy.ini
  right x * 4 / 3
  up y
  location <0, 0, -50>
  look_at <0, 0, 0>
}

#declare SUN_POSITION = <-23000, 0, 0>;

// Sun
light_source {
  SUN_POSITION
  color rgb 1
}

// Anti-Sun (dimmer)
light_source {
  SUN_POSITION
  color rgb 0.25
}

#declare LiteBIRD = object {
  union {
    // Body
    prism {
      linear_sweep
      linear_spline
      0, // sweep the following shape from here ...
      10, // ... up through here
      7, // the number of points making up the shape ...
      <3,5>, <-3,5>, <-5,0>, <-3,-5>, <3, -5>, <5,0>, <3,5>
      pigment { Yellow }
    }

    // V-grooves
    difference {
      cone {
        <0, 8, 0>, 0
        <0, 13, 0>, 10
      }
      cone {
        <0, 8, 0>, 0
        <0, 13, 0>, 8
      }
      
      pigment { Gray }
    }

    // Solar panels
    union {
      box {
        <-3, -0.1, -3>, <-13, 0.1, 3>
        rotate 30*y
      }
      box {
        <-3, -0.1, -3>, <-13, 0.1, 3>
        rotate 150*y
      }
      box {
        <-3, -0.10, -3>, <-13, 0.1, 3>
        rotate -90*y
      }
      
      pigment { DimGray }
    }

    // Spin axis
    object {
      cylinder {
        <0, 0, 0>, <0, 1000, 0>,
        0.1
      }
      
      translate 8*y
      pigment { DimGray }
      no_shadow
    }
    
    // Laser beam for LFT
    object {
      cylinder {
        <0, 0, 0>, <0, 1000, 0>,
        0.1
      }
      
      rotate bore_spin_angle*z
      translate 8*y
      pigment { Red }
      no_shadow
    }

    // Laser beam for MHFT
    object {
      cylinder {
        <0, 0, 0>, <0, 1000, 0>,
        0.1
      }

      rotate -bore_spin_angle*z
      translate 8*y
      pigment { Green }
      no_shadow
    }
  }
}

object {
  LiteBIRD

  rotate -360 * (clock / spin_period_min) * y
  rotate (-90 + spin_sun_angle) * z
  
  // The negative sign allows to see early in the animation the inner part of the V-grooves
  rotate -360 * (clock / prec_period_min) * x
}

// Sun-L2 direction
cylinder {
  SUN_POSITION, <0, 0, 0>, 0.1
  pigment { Blue }
  no_shadow
}
