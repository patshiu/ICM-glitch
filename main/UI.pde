//UTILITY MODULE - GUI 
//-------------------
//This module creates a GUI for this image glitching app. 

//This adds the top bar

int headerHeight = 48; 
float headerPos = 0; 
boolean headerInFull = true;
PGraphics headerBar; //NOTE: This MUST be declared in setup 

int sidebarWidth = 300; 
float sidebarPos; 
boolean sidebarInFull = true; 
PGraphics sidebar; 

//Element for header

//Elements for drift glitch
Toggle driftToggle; 

//Elements for square glitch
Toggle squareGlitchOnOff; 
Slider squareGlitchSize; 
Slider squareGlitchAspect; 

void drawUI(){
	addHeader();
	addSidebar();
}


//This adds the top bar
void addHeader(){
	if (headerBar == null){
		headerBar = createGraphics(width, headerHeight); 
	}

	headerBar.beginDraw();
	headerBar.fill(255, 0, 0);
	headerBar.rect(0, 0, width, headerHeight); 
	headerBar.rect(10,5, 300, 38); //Holder for logo
	headerBar.fill( 0, 0, 255); //Holder for btns
	headerBar.rect(width - 510, 5, 500, 38);
	headerBar.endDraw();
	displayHeader();
}

//This hides / unhides the header
void toggleHeader(){
	if (headerInFull == true) {
		headerInFull = false;
		println("Header is now gonna be hiding.");
		return;
	}
	if (headerInFull == false) {
		headerInFull = true; 
		println("Header is now gonna be in full.");
		return;
	}
}

void displayHeader(){
	//Make the header hide
	if (headerInFull == false){
		if (headerPos > -48){
			headerPos-= 5 + ( abs(headerPos) - 48 / 10); 
			constrain(headerPos, 0, -48);
		}
		image(headerBar, 0, headerPos, width, headerHeight);
		return;
	}
	//Made the header show
	if (headerInFull == true){
		if (headerPos < 0){
			headerPos += 5 + ( abs(headerPos) / 10); 
			constrain(headerPos, 0, -48);
		}
		image(headerBar, 0, headerPos, width, headerHeight);
		return;
	}
}


//This adds the sidebar control panel 
void addSidebar(){
	if (sidebar == null){
		initSidebar();
	}
	sidebar.beginDraw();
	sidebar.fill(255, 0, 0);
	sidebar.rect( 0, 0, sidebarWidth, sidebar.height);
	sidebar.fill( 0, 0, 255); //Holder for filter settings
	sidebar.rect( 10, 20, sidebarWidth-20, 400);
	sidebar.rect( 10, 20 + 400 + 10, sidebarWidth-20, 400);
	sidebar.endDraw();
	displaySidebar();
	
}

void initSidebar() { //sets up sidebar
	//set up sidebar canvas
	sidebar = createGraphics(sidebarWidth, height - headerHeight - 20); 
	sidebarPos = width - sidebarWidth;

	//set up all the control elements
	//Elements for Drift Glitch
	driftToggle = new Toggle(true, 0, 0);

	//Elements for Square Glitch
	squareGlitchOnOff = new Toggle(true, 0, 0);
	squareGlitchSize = new Slider(100, 0, 0); //Make sure slider inits with right button position
	squareGlitchAspect = new Slider(50, 0, 0);


}

void toggleSidebar() {
	if (sidebarInFull == true) {
		sidebarInFull = false;
		println("Sidebar is now gonna be hiding.");
		return;
	}
	if (sidebarInFull == false) {
		sidebarInFull = true; 
		println("Sidebar is now gonna be in full.");
		return;
	}
}

void displaySidebar() {
	//Make the sidebar hide
	if (sidebarInFull == false){
		if (sidebarPos < width){
			sidebarPos+= 5 + (abs(width - sidebarPos) / 10);
			constrain(sidebarPos, width - sidebarWidth, width);
		}
		image(sidebar, sidebarPos, headerHeight + 10);
		return;
	}
	//Made the sidebar show | decrease width to width-sidebarWidth
	if (sidebarInFull == true){
		if (sidebarPos > (width - sidebarWidth) ){
			sidebarPos -= 5 + (abs((width - sidebarWidth) - sidebarPos) / 10);
			constrain(sidebarPos, width - sidebarWidth, width);
		}
		image(sidebar, sidebarPos, headerHeight + 10);
		return;
	}
}


