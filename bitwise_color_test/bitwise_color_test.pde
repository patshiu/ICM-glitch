PImage testImage; 
PImage manipImage; 

void setup() {
	background(0);
	testImage = loadImage("data/palette.png");
	size(testImage.width + 40 , testImage.height + 40);
}

void draw() {
	background(0);
	image(testImage,20,20);

	float lumR = 0, lumG = 0, lumB=0;

	int getX = int(mouseX - 20); 
	int getY = int(mouseY - 20);

	int c = testImage.get( getX, getY); 
	lumB+=(c&0xFF);
	lumG+=((c&0xFF00)>>8);
	lumR+=((c&0xFF0000)>>16);

	println( lumR + " , " + lumG + " , " + lumB);

}