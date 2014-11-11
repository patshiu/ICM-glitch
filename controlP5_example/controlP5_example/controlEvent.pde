void controlEvent(ControlEvent theEvent) {
  /* events triggered by controllers are automatically forwarded to 
     the controlEvent method. by checking the name of a controller one can 
     distinguish which of the controllers has been changed.
  */ 
 
  /* check if the event is from a controller otherwise you'll get an error
     when clicking other interface elements like Radiobutton that don't support
     the controller() methods
  */
  
  if(theEvent.isController()) { 
    
    print("control event from : "+theEvent.controller().name());
    println(", value : "+theEvent.controller().value());
    
    if(theEvent.controller().name()=="bang1") {
      colors[0] = colors[0] + color(40,40,0);
      if(colors[0]>255) colors[0] = color(40,40,0);    
    }
    
    if(theEvent.controller().name()=="button1") {
      colors[1] = colors[1] + color(40,0,40);
      if(colors[1]>255) colors[1] = color(40,0,40);
    }
    
    if(theEvent.controller().name()=="toggle1") {
      if(theEvent.controller().value()==1) colors[2] = color(0,255,255);
      else                                 colors[2] = color(0,0,0);
    }
    
    if(theEvent.controller().name()=="slider1") {
      colors[3] = color(theEvent.controller().value(),0,0);
    }
    
    if(theEvent.controller().name()=="slider2") {
      colors[4] = color(0,theEvent.controller().value(),0);
    }
      
    if(theEvent.controller().name()=="knob1") {
      colors[5] = color(0,0,theEvent.controller().value());
    }
    
    if(theEvent.controller().name()=="numberbox1") {
      colors[6] = color(theEvent.controller().value());
    } 
    
  }  
}
