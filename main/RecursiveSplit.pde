// mouse-over to change parameters, have to move mouse slowly
// x co-ord = detail (move right for more detail, left for less)
// y co-ord = glitch (move down for more glitch, up for less glitch)
 
float MAX_ASPECT = 65.0; // maximum aspect ratio of rectangle
float MAX_SIZE = 2.0;    // minimum size of rectangle/ellipse on shortest axis

class RecursiveSplit {

  boolean isOn; 

  float MAX_ASPECT; // maximum aspect ratio of rectangle
  float MAX_SIZE;    // minimum size of rectangle/ellipse on shortest axis

  PImage img; 
  PGraphics tempCanvas; 
  float x, y, w, h; 

  //Constructor
  RecursiveSplit(PImage inputImage){
    MAX_ASPECT = 55.0; 
    MAX_SIZE = 4.0;
    isOn = true;
    img = inputImage;
    tempCanvas = createGraphics(inputImage.width, inputImage.height, P2D);
  }


  //The method updates img to whatever's showing on the canvas
  void updateImg(PImage inputImage) {
    img = inputImage;
  }

  //This method update the glitch factor params according to mouse position
  void updateGlitchParams(){
    MAX_ASPECT = map( squareGlitchSize.sliderValue, 0, 255, 55.0, 65.0);
    //MAX_SIZE = map( squareGlitchAspect.sliderValue, 0, 255, 4.0, 80.0);
    MAX_SIZE = map( squareGlitchSize.sliderValue, 0, 255, 4.0, 80.0); //Temporarily mapping this to the squareGlitchSize slider value
  }

  void run(float x, float y, float w, float h){
    if ( pauseSketch == false ){
      tempCanvas.beginDraw();
      tempCanvas.clear();
      if( isOn == true){
        splitImage(x, y, w, h);
      }
      tempCanvas.endDraw();
      image(tempCanvas, 0, 0);
      return;
    }
    else {
      image(tempCanvas, 0, 0); //just keep drawing the last updated canvas
    }

  }

  //Apply the glitch
  void splitImage(float x, float y, float w, float h) {
      // abandon squares whose aspect ratio is too high
      // e.g. width is 16x height, or vice versa
      boolean ok = ( w/h < MAX_ASPECT && h/w < MAX_ASPECT );
      if (!ok) return; //If aspect ratio is not pretty, bail

      if ( w <= MAX_SIZE && h <= MAX_SIZE) { //If the input width or height is smaller than the MAX_SIZE limit (between 2 and 80) then draw it.
        // fill with the average colour of pixels in the rectangle !?!?
        // shouldn't take too long as the size is restricted 
        float lumR = 0, lumG = 0, lumB=0, sqAlpha=0;
        //iteratorX starts at origin X value, ends at origin X plus width of image specified. 
         for (float iterY = y; iterY < y+h; iterY += 3){
          //iteratorY starts at origin Y value, and ends at origin Y plus height of image specified
          for (float iterX = x; iterX < x+w; iterX += 3) {
            //iterator Y is multiplied by the image's width, and then iteratorX is added to it. 
            int currentPixel = (int)iterY*img.width + (int)iterX;
            int c = img.pixels[currentPixel]; 

            lumR = red(c);
            lumG = green(c);
            lumB = blue(c);
            sqAlpha = random(100,200); //Randomize Alpha

            lumR -= random(50); //Darken at random
            lumG -= random(50);
            lumB -= random(50);

            tempCanvas.fill(lumR, lumG, lumB, sqAlpha);
            tempCanvas.noStroke();
            //tempCanvas.rect(x + random(-2,2), y + random(-3,3), w , h); //With noise dither
            tempCanvas.rect(x, y, w, h); //Without noise dither
            return;
          }
        }
      }

      // otherwise, split rectangle / ellipse recursively at random into either
      // (0) two rectangles horizontally
      // (1) two rectangles vertically
      // (2) into quarters

      int splittype=(int)random(2); //!!This might never round to 2
      switch(splittype) { //switch Works like an if else structure
        case(0): 
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

