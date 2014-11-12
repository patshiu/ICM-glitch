//UTILITY MODULE - GUI 
//-------------------
//This module creates a GUI for this image glitching app. 

//* * * * * * *
//1st
//Check out control p5 lib
//* * * * * * *

import controlP5.*;

//Import button 

//Color Label
//Color controls

//Focus Label
//Focus controls

//Displace Label
//Displace controls

//Recursive Label
//Recursive controls

//Reset button 

//Export button 

void UIsetup(){

	cp5 = new ControlP5(this);

	cp5.addSlider("sliderValue")
	.setPosition(-200,50)
	.setSize(100, 20)
	.setRange(0,255)
	//.setNumberOfTickMarks(5)
	;

	cp5.addSlider("sliderValue2")
	.setPosition(-200,100)
	.setRange(0,255)
	;
}