# VRML V2.0 utf8

# A simple rotating cube
Transform {
  rotation 0 1 0 0
  children [
    Shape {
      appearance Appearance {
        material Material {
          diffuseColor 0 1 0
        }
      }
      geometry Box { size 2 2 2 }
    }
  ]
}
