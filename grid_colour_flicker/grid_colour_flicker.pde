//Grid is drawn and uses flickering colors to appear glitch-like

//variables below are for Flower rotating shapes, not Grid
float p, q, r, g, b, radius;
int timer;
float rotate;

void setup () {
  size (500, 500);
}

void draw () {

  background (255, 10);
  
  //variables for drawing the grid
  float x = 0;
  float y = 0;
  int spacing = 50;

  //columns and rows
  int cols = width / spacing;
  int rows = height / spacing;

  // noStroke ();

  //this For loop draws the grid across the page
  for (x = 0; x < cols; x = x + 1) {
    for (y = 0; y < rows; y = y + 1) {
      if (x % 2 == 0) {
        stroke(0);
        fill(0, 0, random(100, 255)); //random colours appears to be animated
      } else {
        // stroke(255);
        fill(0, 0, random(200, 255)); //random colours appears to be animated
      } 
      rect (x*spacing, y*spacing, spacing, spacing);
    }
  }


  //this draws the rotating square flower
  // pushMatrix();
  // translate(width / 2, height / 2);
  // for (int s = 100; s > 0; s = s - 3) {
  //   fill(0, 255 - s, 255 - s, 122);
  //   // fill(255-s,122);
  //   // rotate((mouseX + mouseY) / 300.0);
  //   rotate((rotate) / 200.0);
  //   stroke(255, 10);
  //   rect(0, 0, s, s);
  //   // ellipse(0,0,s,s*2);
  // }
  // popMatrix();
  // rotate += 2; 


  //this draws the rotating ellipse flower
  // pushMatrix();
  // translate(width / 3, height / 4);
  // for (int s = 90; s > 0; s = s - 3) {
  //   fill(220, 220, 255 - s, 122);
  //   // fill(255-s,122);
  //   // rotate((mouseX + mouseY) / 300.0);
  //   rotate((rotate) / 200.0);
  //   stroke(255, 10);
  //   ellipse(0, 0, s, s*2);
  // }
  // popMatrix();
  // rotate += 2;
  
    // use frameCount to move x, use modulo to keep it within bounds
  // p = frameCount % width;
 
  // // use millis() and a timer to change the y every 2 seconds
  // if (millis() - timer >= 1000) {
  //   q = random(height);
  //   // q = cos(random(height+100));
  //   timer = millis();
  // }
 
  // // use frameCount and noise to change the red color component
  // r = noise(frameCount * 0.01) * 255;
 
  // // use frameCount and modulo to change the green color component
  // g = frameCount % 55;
 
  // // use frameCount and noise to change the blue color component
  // b = 255 - noise(1 + frameCount * 0.025) * 255;
 
  // // use frameCount and noise to change the radius
  // radius = noise(frameCount * 0.01) * 100;
 
  // color c = color(r, g, b);
  // fill(c);
  // ellipse(p, q, radius, radius);
  
}
