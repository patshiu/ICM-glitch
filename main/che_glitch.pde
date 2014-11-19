// mouse-over to change parameters, have to move mouse slowly
// x co-ord = detail (move right for more detail, left for less)
// y co-ord = glitch (move down for more glitch, up for less glitch)
 
float MAX_ASPECT = 65.0; // maximum aspect ratio of rectangle
float MIN_SIZE = 2.0;    // minimum size of rectangle/ellipse on shortest axis

class CheGlitch {

  boolean isOn; 

  float MAX_ASPECT; // maximum aspect ratio of rectangle
  float MIN_SIZE;    // minimum size of rectangle/ellipse on shortest axis

  PImage img; 
  float x, y, w, h; 

  //Constructor
  CheGlitch(PImage inputImage){
    MAX_ASPECT = 65.0; 
    MIN_SIZE = 2.0; 
    isOn = true;
    img = inputImage;
  }


  //The method updates img to whatever's showing on the canvas
  void updateImg(PImage inputImage) {
    img = inputImage;
  }

  //This method update the glitch factor params according to mouse position
  void updateGlitchParams(){
    MAX_ASPECT = map( squareGlitchSize.sliderValue, 0, 255, 55.0, 65.0);
    //MIN_SIZE = map( squareGlitchAspect.sliderValue, 0, 255, 2.0, 80.0);
    MIN_SIZE = map( squareGlitchSize.sliderValue, 0, 255, 2.0, 80.0); //Temporarily mapping this to the squareGlitchSize slider value
  }

  //Apply the glitch
  void splitImage(float x, float y, float w, float h) {
    if( isOn == true){
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
        for (float iterX = x; iterX < x+w; iterX++) {
          for (float iterY = y; iterY < y+h; iterY++) {
            area++;
            int c = img.pixels[(int)iterY*img.width + (int)iterX];
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
        //ellipseMode(CENTER);
        //ellipse(x, y, w, w);
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
}

