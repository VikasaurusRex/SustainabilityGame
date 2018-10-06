//
//  ControlPanel
//  
//  This is the class for the Control Panel, which will be physical on the 
//  final project. In this form it is shown by 3 partitions that would 
//  represent each panel of the triple panel control structure on the final 
//  project.
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/4/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//

class ControlPanel{
  // These variables are for positioning the ControlPanel in the screen
  float panelX,panelY,panelWidth,panelHeight;
  String timerText = "Timer: 0";
  // These variables are for determining what to light up
  boolean solar = false, wind = false, coal = false;
  int throwSwitch = 0;
  
  // the timer variables
  float timer = 0;
  boolean isTiming = false;
  
  // draws the panel by drawing each of the components.
  void drawPanel(float panelX, float panelY, float panelWidth, float panelHeight ){
    //the dimentions of the panel
    this.panelX = panelX;
    this.panelY = panelY;
    this.panelWidth = panelWidth;
    this.panelHeight = panelHeight;
    
    // the functions that actually draw each of the components.
    frame();
    doubleThrow();
    scoreBoard();
    buttons();
  }
  
  // Just frames out the Panel to make it look nice (light grey lines)
  void frame(){
    fill(0);
    strokeWeight(3);
    stroke(150);
    rect(panelX,panelY,panelWidth,panelHeight);
    
    line(panelX+panelWidth/3,panelY,panelX+panelWidth/3,panelY+panelHeight); // first third
    line(panelX+2*panelWidth/3,panelY,panelX+2*panelWidth/3,panelY+panelHeight); // second third
  }
  
  //Draws out the double throw switch
  void doubleThrow(){
    strokeWeight(3);
    stroke(150);
    fill(255);
    textSize(15);
    text("Charge (UP Arrow)", panelX+panelWidth/3+panelWidth/3/2, panelY+0.5*panelHeight/5);
    text("Use Reserve\n(DOWN Arrow)", panelX+panelWidth/3+panelWidth/3/2, panelY+4.5*panelHeight/5);
    fill(200);
    rect(panelX+panelWidth/3+panelWidth/3/4, panelY + panelHeight/5, panelWidth/3/2, 3*panelHeight/5);
    
    // This is the actul switch part, drawn based on its position.
    fill(100);
    noStroke();
    rect(panelX+panelWidth/3+panelWidth/3/4, panelY + (-1*throwSwitch+2)*panelHeight/5, panelWidth/3/2, panelHeight/5);
  }
  
  // Draws the timer/scoreboard.
  void scoreBoard(){
    strokeWeight(3);
    stroke(150);
    fill(200);
    rect(panelX+2*panelWidth/3+panelWidth/3/8, panelY + 2*panelHeight/5, panelWidth/4, panelHeight/5);
    fill(0);
    textSize(15);
    
    // Displays the time by using the incremented value divided by framerate.
    timerText = "Timer: " + int(timer/30);
    text(timerText,panelX+2*panelWidth/3+panelWidth/3/2, panelY + panelHeight/2);
    if(isTiming){
      timer++;
    }
  }
  
  // Draws the buttons
  void buttons(){
    strokeWeight(3);
    stroke(150);
    
    // Each button is drawn below with respect to whether it is on or off.
    fill(solar?100:200);
    rect(panelX+panelWidth/3/7, panelY + panelHeight/5, panelWidth/3/7, panelHeight/5);
    fill(coal?100:200);
    rect(panelX+5*panelWidth/3/7, panelY + panelHeight/5, panelWidth/3/7, panelHeight/5);
    fill(wind?100:200);
    rect(panelX+3*panelWidth/3/7, panelY + 3*panelHeight/5, panelWidth/3/7, panelHeight/5);
    
    fill(255);
    text("Solar (30%)\n('A')\n", panelX+1.5*panelWidth/3/7, panelY + 2.5*panelHeight/5);
    text("Coal (40%)\n('S')\nTry to avoid.", panelX+5.5*panelWidth/3/7, panelY + 2.5*panelHeight/5);
    text("Wind (25%)\n('Z')", panelX+3.5*panelWidth/3/7, panelY + 4.5*panelHeight/5);
  }
  
  String getTimerText(){
    return timerText;
  }
  
  // Resets the timer
  void resetTimer(){
    timer = 0;
  }
  
  // Starts the timer
  void startTimer(){
    isTiming = true;
  }
  
  // Ends the timer
  void endTimer(){
    isTiming = false;
  }
  
  // Switch moved up
  void incrementSwitch(){
    throwSwitch++;
    if(throwSwitch > 1)
      throwSwitch = 1;
  }
  
  // Switch moced down
  void decrementSwitch(){
    throwSwitch--;
    if(throwSwitch < -1)
      throwSwitch = -1;
  }
  
  void switchUp(){
      throwSwitch = 1;
  }
  
  void switchDown(){
      throwSwitch = -1;
  }
  void switchMiddle(){
      throwSwitch = 0;
  }
  
  // Toggle wind switch
  void windToggle(){
    wind = !wind;
  }
  
  // Toggle solar switch
  void solarToggle(){
    solar = !solar;
  }
  
  // Toggle coal switch
  void coalToggle(){
    coal = !coal;
  }
  
  // Turn wind on
  void windOn(){
    wind = true;
  }
  
  // Turn solar on
  void solarOn(){
    solar = true;
  }
  
  // Turn coal on
  void coalOn(){
    coal = true;
  }
  
  // Turn wind on
  void windOff(){
    wind = false;
  }
  
  // Turn solar on
  void solarOff(){
    solar = false;
  }
  
  // Turn coal on
  void coalOff(){
    coal = false;
  }
  
  // Return position of wind switch
  boolean getWind(){
    return wind;
  }
  
  // Return position of solar switch
  boolean getSolar(){
    return solar;
  }
  
  // Return position of coal switch
  boolean getCoal(){
    return coal;
  }
  
  // Return position of throw switch
  int getSwitch(){
    return throwSwitch;
  }
  
  // Return the positions of all the inputs in one Input variable.
  Input getInput(){
    return new Input(solar, wind, coal, throwSwitch);
  }
}