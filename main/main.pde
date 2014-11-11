// GLITCH 
// ICM 2014 Final Project by 
// Tommy Payne & Pat Shiu
// tommypayne.org | obsesstheprocess.com


PImage testImg; 
PGraphics sketchPad; 
DisplacementCloud imgCloud; 

void setup() {
	size(900, 900);
	background(0);
	testImg = loadImage("data/gilmore.jpg");
	imgCloud = new DisplacementCloud(testImg);
	sketchPad = createGraphics(testImg.width, testImg.height);
	imgCloud.flockToField(int(1));

}

void draw() {
	background(0);
	
	imgCloud.run();
	//image(testImg, 0, 0 );

}