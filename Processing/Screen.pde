//
//  Screen
//  
//  This is the class for the Output Board, which will persist 
//  digitally on the final project. The screen will interface 
//  with the user to provide high quality real time analysis of 
//  their selections and express what the environmental 
//  condition is that they need to solve for. It will likely be 
//  on this Mac computer on the final project with wires coming 
//  from this comuter to the arduino.
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/4/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//
class Screen{
  // Screen dimentions
  float screenX,screenY,screenWidth,screenHeight;
  
  // the last line of text changes if it is the last in the array
  boolean isLast;
  
  // We have a few objects passed for referance to see what we 
  // display on indicators etc.
  ControlPanel panel;
  EnvironmentalOutput output;
  
  // Draws the screen
  void drawScreen(ControlPanel panel, EnvironmentalOutput output, float screenX, float screenY, float screenWidth, float screenHeight){
    // First we pass the dimentions and referance variables
    this.screenX = screenX;
    this.screenY = screenY;
    this.screenWidth = screenWidth;
    this.screenHeight = screenHeight;
    this.panel = panel;
    this.output = output;
    
    // These lines draw the rest of the screen.
    frame();
    indicators();
    powerLevels();
    outputText();
  }
  
  // Draws a frame sround the section for the screen. Also the divider lines.
  void frame(){
    // Border:
    fill(0);
    strokeWeight(3);
    stroke(150);
    rect(screenX,screenY,screenWidth,screenHeight);
    
    // Divider lines:
    line(screenX+screenWidth/3,screenY,screenX+screenWidth/3,screenY+screenHeight);
    line(screenX+2*screenWidth/3,screenY,screenX+2*screenWidth/3,screenY+screenHeight);
  }
  
  void indicators(){
    // Throws the indicator images on the screen:
    imageMode(CENTER);
    float dim = 2*screenWidth/3/7 > screenHeight/8? screenHeight/8 : 2*screenWidth/3/7;
    image(loadImage("sun.jpg"), screenX+2*screenWidth/3/7,screenY+1.5*screenHeight/8, dim, dim);
    image(loadImage("wind.jpg"), screenX+5*screenWidth/3/7,screenY+1.5*screenHeight/8, dim, dim);
    
    image(loadImage("turbine.jpg"), screenX+2*screenWidth/3/7,screenY+3.5*screenHeight/8, dim, dim);
    image(loadImage("solar.jpg"), screenX+5*screenWidth/3/7,screenY+3.5*screenHeight/8, dim, dim);
    
    image(loadImage("coal.jpg"), screenX+2*screenWidth/3/7,screenY+5.5*screenHeight/8, dim, dim);
    image(loadImage("charge.jpg"), screenX+5*screenWidth/3/7,screenY+5.5*screenHeight/8, dim, dim);
    
    // Also we need labels:
    textSize(15);
    fill(255);
    text("Sunny", screenX + 2*screenWidth/3/7, screenY + 4.5*screenHeight/16);
    text("Windy", screenX + 5*screenWidth/3/7, screenY + 4.5*screenHeight/16);
    
    text("Wind Power", screenX + 2*screenWidth/3/7, screenY + 8.5*screenHeight/16);
    text("Solar Power", screenX + 5*screenWidth/3/7, screenY + 8.5*screenHeight/16);
    
    text("Coal", screenX + 2*screenWidth/3/7, screenY + 12.5*screenHeight/16);
    text("Charging", screenX + 5*screenWidth/3/7, screenY + 12.5*screenHeight/16);
    
    // Basically, for each indicator light, if it 
    // should be on the shapes fill is changed to green, otherwise it remains red.
    fill(200,0,0);
    noStroke();
    fill(200,0,0);
    if(output.isSunny())
      fill(29,185,84);
    // SUNNY
    ellipse(screenX + 2*screenWidth/3/7, screenY + 5.5*screenHeight/16, 10, 10);
    fill(200,0,0);
    if(output.isWindy())
      fill(29,185,84);
    // WINDY
    ellipse(screenX + 5*screenWidth/3/7, screenY + 5.5*screenHeight/16, 10, 10);
    
    fill(200,0,0);
    if(panel.getWind())
      fill(29,185,84);
    // WIND
    ellipse(screenX + 2*screenWidth/3/7, screenY + 9.5*screenHeight/16, 10, 10);
    fill(200,0,0);
    if(panel.getSolar())
      fill(29,185,84);
    // SOLAR
    ellipse(screenX + 5*screenWidth/3/7, screenY + 9.5*screenHeight/16, 10, 10);
    
    fill(200,0,0);
    if(panel.getCoal())
      fill(29,185,84);
    // COAL
    ellipse(screenX + 2*screenWidth/3/7, screenY + 13.5*screenHeight/16, 10, 10);
    fill(200,0,0);
    if(panel.getSwitch() == 1)
      fill(29,185,84);
    // CHARGING
    ellipse(screenX + 5*screenWidth/3/7, screenY + 13.5*screenHeight/16, 10, 10);
    
  }
  
  // Displays the power level graphs
  void powerLevels(){
    //Each block first draws the outline of the graph
    // Then given a numebr between 1-100 to represent 
    // what level, it uses quick maths to figure out 
    // where to draw the line based on these inputted 
    // values.
    
    // Draws the outline
    strokeWeight(3);
    stroke(255);
    textSize(15);
    fill(255);
    line(screenX+screenWidth/3+screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+3*screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+3*screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+screenWidth/3/10, screenY+3*screenHeight/4, screenX+screenWidth/3+3*screenWidth/3/10, screenY+3*screenHeight/4);
    // Draws the GENERATED value.
    stroke(29,185,84);
    float generatedValue = (panel.getWind()?25:0) + (panel.getCoal()?40:0) + (panel.getSolar()?30:0);
    float heightGenerated = screenY + (1+2*(100-generatedValue)/100)*screenHeight/4;
    line(screenX+screenWidth/3+screenWidth/3/10, heightGenerated, screenX+screenWidth/3+3*screenWidth/3/10, heightGenerated);
    
    // Draws the outline
    stroke(255);
    line(screenX+screenWidth/3+4*screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+4*screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+6*screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+6*screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+4*screenWidth/3/10, screenY+3*screenHeight/4, screenX+screenWidth/3+6*screenWidth/3/10, screenY+3*screenHeight/4);
    stroke(200,0,0);
    // Draws the USED value.
    float heightUsed = screenY + (1+2*(1-output.usedPower()/100))*screenHeight/4;
    line(screenX+screenWidth/3+4*screenWidth/3/10, heightUsed, screenX+screenWidth/3+6*screenWidth/3/10, heightUsed);
    
    // Draws the outline
    stroke(255);
    line(screenX+screenWidth/3+7*screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+7*screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+9*screenWidth/3/10, screenY+screenHeight/4, screenX+screenWidth/3+9*screenWidth/3/10, screenY+3*screenHeight/4);
    line(screenX+screenWidth/3+7*screenWidth/3/10, screenY+3*screenHeight/4, screenX+screenWidth/3+9*screenWidth/3/10, screenY+3*screenHeight/4);
    // Draws the RESERVE value
    stroke(50,50,255);
    float heightReserve = screenY + (1+2*(1-output.reservePower()/100))*screenHeight/4;
    line(screenX+screenWidth/3+7*screenWidth/3/10, heightReserve, screenX+screenWidth/3+9*screenWidth/3/10, heightReserve);
    
    // And add some labels for good measure:
    text("Generated",screenX+screenWidth/3+2*screenWidth/3/10, screenY+7*screenHeight/8);
    text("Used",screenX+screenWidth/3+5*screenWidth/3/10, screenY+7*screenHeight/8);
    text("Reserve",screenX+screenWidth/3+8*screenWidth/3/10, screenY+7*screenHeight/8);
    
    textSize(30);
    text("Power Graphs",screenX+screenWidth/3+screenWidth/3/2, screenY+1*screenHeight/8);
  }
  
  //Here we write the text that is directly from the EnvironmentalOutput passes into the class.
  void outputText(){
    textSize(20);
    fill(255);
    
    // Gets the line, and writes it on the program.
    text(output.lineOne(),screenX+5*screenWidth/6, screenY + screenHeight/6);
    text(output.lineTwo(),screenX+5*screenWidth/6, screenY + screenHeight/3);
    text(output.lineThree(),screenX+5*screenWidth/6, screenY + 3*screenHeight/6);
    text("If Generated > Used -> \"Charge\"\nOtherwise \"Use Reserve\".",screenX+5*screenWidth/6, screenY + 2*screenHeight/3);
    // if last value, display "Please turn off switches to Play Again" instead of
    // "Find the correct settings as fast as you can!"
    text(isLast?"Please turn off switches \nto Play Again":"Find the correct settings\nas fast as you can!",screenX+5*screenWidth/6, screenY + 5*screenHeight/6);
  }
  
  // to determine if it is at last value in array:
  void isLast(){
    isLast = true;
  }
  
  void isntLast(){
    isLast = false;
  }
}