//
//  Input
//  
//  This is the class for representing a combination of inputs
//  Each input combination can be compared to a desired input 
//  combination to determine if the user has passed this stage 
//  of the day's environmental condition. Once the inupt given 
//  matches the theorhetical input required, the game changes 
//  to the next stage with a new required input.
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/4/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//

class Input{
  boolean solarPower;
  boolean windPower;
  boolean coalPower;
  int throwSwitch;

  // An input consists of 3 booleans and an int that indicate 
  // the position of the switches on the ControlPanel
  public Input(boolean solarPower, boolean windPower, boolean coalPower, int throwSwitch){
    this.solarPower = solarPower;
    this.windPower = windPower;
    this.coalPower = coalPower;
    this.throwSwitch = throwSwitch;
  }
  
  boolean getSolar(){
    return solarPower;
  }
  
  boolean getWind(){
    return windPower;
  }
  
  boolean getCoal(){
    return coalPower;
  }
  
  int getThrowSwitch(){
    return throwSwitch;
  }
  
  // Determines if the given input is the same as another 
  // input (to move forward in game))
  boolean isEqualInput(Input input){
    return solarPower == input.getSolar() && windPower == input.getWind() && coalPower == input.getCoal() && throwSwitch == input.getThrowSwitch();
  }
}