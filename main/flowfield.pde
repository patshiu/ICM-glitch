class FlowField {
	PVector [] [] field; 
	int cols, rows; 
	int resolution; 

	float xoff; 
	float yoff;

	FlowField(){
		resolution = 10;
		cols = width/resolution; 
		rows = height/resolution; 
		field = new PVector [cols] [rows];

		xoff = millis();
		yoff = millis()*2;

		init();
	}

	PVector lookup(PVector lookup){
		int column = int(constrain(lookup.x/resolution,0,cols-1));
		int row = int(constrain(lookup.y/resolution,0,rows-1));

		return field[column][row].get();
	}


	void init() {
		//Initialize force field directions
		xoff = 0;
		yoff = 0;

		for (int i = 0; i < cols; i++){
			for (int j = 0; j < rows; j++) {
				float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
				field[i][j] = new PVector(cos(theta),sin(theta));
				//yoff += 0.1;
				yoff += random(0,0.2);
			}
			xoff += 0.1;
		}
	}


}