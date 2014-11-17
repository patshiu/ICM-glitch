//Make a custom toggle button class

//Make a custom slider class

//TOGGLE BUTTON

//Have a boolean state
//When user clicks on the object, toggle that state and swap corresponding image


class ToggleBtn {
	boolean isOn; 
	PImage btnOn; 
	PImage btnOff;
	PGraphics toggleBtnCanvas;
	boolean isUnderCursor; 
	float locX; 
	float locY; 


	ToggleBtn(boolean initState, float x, float y) {
		isOn = initState; 
		btnOn = loadImage("btn_toggle_ON.png");
		btnOff = loadImage("btn_toggle_OFF.png");
		locX = x; 
		locY = y; 
		toggleBtnCanvas = createGraphics(btnOn.width, btnOn.height); 
		isUnderCursor = false; 
	}

	void toggle () {

		//Check if the mouse click is on the object. 
		if (isOn == true){
			isOn = false;
			return; 
		}
		if (isOn == false){
			isOn = true;
			return; 
		}
	}

	PGraphics show(){ //THIS RETURNS A PGRAPHICS
		toggleBtnCanvas.beginDraw();
		toggleBtnCanvas.clear();
		if( isOn == true){
			toggleBtnCanvas.image(btnOn, 0, 0);
		}
		else {
			toggleBtnCanvas.image(btnOff, 0, 0);
		}
		toggleBtnCanvas.endDraw();
		return toggleBtnCanvas;
	}

	Boolean isUnderCursor() {
		if( mouseX >= locX && mouseX <= (locX + btnOn.width) && mouseY >= locY && mouseY <= (locY + btnOn.height)){
			return true; 
		} else {
			return false;
		}

	}
}

//SLIDER
//Have a value that is constrained to a range
//When user clicks and drags on the object, move the slider btn image, update the value stored

class Slider {
	float sliderValue; 
	PImage sliderBtn; 
	PImage sliderLine;
	PGraphics sliderCanvas;
	boolean isUnderCursor; 
	float locX; 
	float locY; 
	float locBtn;

	Slider(float initVal, float x, float y ){
		sliderValue = constrain(initVal, 0, 255); //This constrains the slider's value 0 - 255
		sliderBtn = loadImage("slider_btn.png");
		sliderLine = loadImage("slider_bg_black.png");
		locX = x; 
		locY = y; 
		locBtn = constrain(initVal, 15, sliderLine.width - sliderBtn.width - 15); 
		sliderCanvas = createGraphics(sliderLine.width, sliderLine.height);
		isUnderCursor = false; 
	}

	void setValue(float input){

		//If mouse press is valid, then move sliderBtn to the correct location on slider
		//Update "sliderValue" to match, using map on 
		float valueIn = input - locX; 
		locBtn = constrain(valueIn, 15, sliderLine.width - sliderBtn.width - 15);
		sliderValue = map(locBtn, 15, sliderLine.width - sliderBtn.width - 15, 0, 255);

	}

	PGraphics show(){ //THIS RETURNS A PGRAPHICS
		sliderCanvas.beginDraw();
		sliderCanvas.clear();
		sliderCanvas.image(sliderLine, 0, 0);
		sliderCanvas.image(sliderBtn, locBtn, 0);
		sliderCanvas.endDraw();
		return sliderCanvas;
	}

	boolean isUnderCursor() {
		//if( mouseX >= locX && mouseX <= (locX + sliderLine.width) && mouseY >= locY && mouseY <= (locY + sliderLine.height)){
		if( mouseX >= locX && mouseX <= sliderLine.width && mouseY >= 60 && mouseY <= 100 ) {
			return true; 
		} else {
			return false;
		}
	}

}


//GUI BTN & SLIDER TEST
//-------------------
//


ToggleBtn onOff; 
Slider slider1;


void setup() {
	size(400, 400);
	onOff = new ToggleBtn(true, 0, 0);
	slider1 = new Slider(20, 0, 0);
}

void draw() {
	background(0);
	image(onOff.show(), 10, 0);
	image(slider1.show(), 10, 60);
	println(slider1.sliderValue);

	//if mouse is press is on slider btn, 
	
 if (mousePressed == true) {
 	if (slider1.isUnderCursor() == true){
 		slider1.setValue(mouseX);
 	}
  } 
}

void mousePressed() {
	if(onOff.isUnderCursor() == true){
		onOff.toggle();
	}


}


