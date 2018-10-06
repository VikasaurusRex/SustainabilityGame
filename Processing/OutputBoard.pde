//
//  OutputBoard
//  
//  This is the class for the Output Board, which will be physical on 
//  the final project. In this form it is represented by 8 placeholding 
//  tiles which light up when their physical structured counterparts 
//  would light up on the final build. Essentially just indicator lights, 
//  similar to the final OutputBoard
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/4/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//

class OutputBoard{
  // The dimentions of the OutputBoard
  float boardX,boardY,boardWidth,boardHeight;
  
  // The required referance objects to look at for indicator lights.
  ControlPanel panel;
  EnvironmentalOutput output;
  
  // Draws the board through drawing the frame and the indicators.
  void drawBoard(ControlPanel panel, EnvironmentalOutput output, float boardX, float boardY, float boardWidth, float boardHeight){
    this.boardX = boardX;
    this.boardY = boardY;
    this.boardWidth = boardWidth;
    this.boardHeight = boardHeight;
    
    // Referance variables
    this.panel = panel;
    this.output = output;
    
    frame();
    indicators();
  }
  
  // Just the frame of the board.
  void frame(){
    fill(0);
    strokeWeight(3);
    stroke(150);
    rect(boardX,boardY,boardWidth,boardHeight);
    
    // These lines section off 8 small sections of the board
    line(boardX + boardWidth/4, boardY, boardX + boardWidth/4, boardY + boardHeight);
    line(boardX + 2*boardWidth/4, boardY, boardX + 2*boardWidth/4, boardY + boardHeight);
    line(boardX + 3*boardWidth/4, boardY, boardX + 3*boardWidth/4, boardY + boardHeight);
    line(boardX, boardY + boardHeight/2, boardX + boardWidth, boardY + boardHeight/2);
  }
  
  // Indicators of each of the components of the board.
  void indicators(){
    fill(255);
    textSize(20);
    
    // Labels:
    text("Coal Power", boardX+boardWidth/8, boardY+boardHeight/4);
    text("Solar Power", boardX+3*boardWidth/8, boardY+boardHeight/4);
    text("Charging", boardX+5*boardWidth/8, boardY+boardHeight/4);
    text("House", boardX+7*boardWidth/8, boardY+boardHeight/4);
    
    text("Sun", boardX+boardWidth/8, boardY+3*boardHeight/4);
    text("Wind Power", boardX+3*boardWidth/8, boardY+3*boardHeight/4);
    text("Discharging", boardX+5*boardWidth/8, boardY+3*boardHeight/4);
    text("Wind", boardX+7*boardWidth/8, boardY+3*boardHeight/4);
    
    // The lights themselves:
    noStroke();
    fill(200,0,0);
    if(panel.getCoal())
      fill(29,185,84);
    // COAL
    ellipse(boardX+boardWidth/8, boardY+3*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(panel.getSolar())
      fill(29,185,84);
    // SOLAR
    ellipse(boardX+3*boardWidth/8, boardY+3*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(panel.getSwitch() == 1)
      fill(29,185,84);
    // DOUBLE THROW SWITCH CHARGING
    ellipse(boardX+5*boardWidth/8, boardY+3*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(output.isHouseLightOn())
      fill(29,185,84);
    // HOUSE LIGHT
    ellipse(boardX+7*boardWidth/8, boardY+3*boardHeight/8, 10, 10);
    
    fill(200,0,0);
    if(output.isSunny())
      fill(29,185,84);
    // SUNNY
    ellipse(boardX+boardWidth/8, boardY+7*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(panel.getWind())
      fill(29,185,84);
    // WINDY
    ellipse(boardX+3*boardWidth/8, boardY+7*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(panel.getSwitch() == -1)
      fill(29,185,84);
    // DOUBLE THROW SWITCH DISCHARGING
    ellipse(boardX+5*boardWidth/8, boardY+7*boardHeight/8, 10, 10);
    fill(200,0,0);
    if(output.isWindy())
      fill(29,185,84);
    // WINDY
    ellipse(boardX+7*boardWidth/8, boardY+7*boardHeight/8, 10, 10);
  }
  
}