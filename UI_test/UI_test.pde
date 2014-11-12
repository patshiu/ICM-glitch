int sliderValue = 100;
int sliderValue2 = 100;


ControlP5 cp5;

void setup(){
	background(0);
	size(400, 400);

	cp5 = new ControlP5(this);

	cp5.addSlider("sliderValue")
	.setPosition(100,50)
	.setSize(100, 20)
	.setRange(0,255)
	//.setNumberOfTickMarks(5)
	;

	cp5.addSlider("sliderValue2")
	.setPosition(100,100)
	.setRange(0,255)
	;
}

void draw(){
 
}