// mouse-over to change parameters, have to move mouse slowly
// x co-ord = detail (move right for more detail, left for less)
// y co-ord = glitch (move down for more glitch, up for less glitch)

PImage im; 
float MAX_ASPECT = 65.0; // maximum aspect ratio of rectangle
float MIN_SIZE = 2.0;    // minimum size of rectangle/ellipse on shortest axis

class CheGlitch {
  float MAX_ASPECT; // maximum aspect ratio of rectangle
  float MIN_SIZE;    // minimum size of rectangle/ellipse on shortest axis
  PImage img; 
  float x, y, w, h; 

  //Constructor
  CheGlitch(){
    MAX_ASPECT = 65.0; 
    MIN_SIZE = 2.0; 
    updateImg();
  }


  //The method updates img to whatever's showing on the canvas
  void updateImg() {
    //img = get();
    img = loadImage("data/palette.png");
  }

  //This method update the glitch factor params according to mouse position
  void updateGlitchParams(){
    MAX_ASPECT = map( mouseY, 0, height, 1.0, 65.0);
    MIN_SIZE = map( mouseX, 0, width, width/10, 2.0);
  }

  //Apply the glitch
  void splitImage(float x, float y, float w, float h) {
    // abandon squares whose aspect ratio is too high
    // e.g. width is 16x height, or vice versa
    boolean ok = ( w/h < MAX_ASPECT && h/w < MAX_ASPECT );
    if (!ok) return;

    // if rectangle is small enough, draw it and bail out

    if ( w <= MIN_SIZE || h <= MIN_SIZE) {
      // fill with the average colour of pixels in the rectangle
      // shouldn't take too long as the size is restricted
      int area = 0;
      float lumR = 0, lumG = 0, lumB=0, sqAlpha=0;
      for (float xx=x; xx<x+w; xx++) {
        for (float yy=y; yy<y+h; yy++) {
          area++;
          int c = img.pixels[(int)yy*img.width + (int)xx];
          lumB+=(c&0xFF);
          lumG+=((c&0xFF00)>>8);
          lumR+=((c&0xFF0000)>>16);
        }
      }
      sqAlpha = random(100,200); //!!! Added random alpha here
      lumR/=area;
      lumG/=area;
      lumB/=area;

      fill(lumR, lumG, lumB, sqAlpha);
      noStroke();
      rect(x,y,w,h);
      // ellipse(x, y, w, h);
      return;
    }

    // otherwise, split rectangle / ellipse recursively at random into either
    // (0) two rectangles horizontally
    // (1) two rectangles vertically
    // (2) into quarters

    int splittype=(int)random(2); //!!This might never round to 2
    switch(splittype) { //switch Works like an if else structure
      case (0): 
      {
        // horizontal split
        splitImage(x, y, w/2, h);
        splitImage(x+(w/2), y, w/2, h);
        break;
      }
      case(1): 
      {
        // vertical split
        splitImage(x, y, w, h/2);
        splitImage(x, y+(h/2), w, h/2); 
        break;
      }
      case(2): 
      {
        // 2x2 grid split
        splitImage(x, y, w/2, h/2);
        splitImage(x+(w/2), y, w/2, h/2);
        splitImage(x, y+(h/2), w/2, h/2);
        splitImage(x+(w/2), y+(h/2), w/2, h/2);
        break;
      }
      default: 
      {
        break;
      }
    }
  }
}

