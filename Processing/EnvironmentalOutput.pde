//
//  EnvironmentalOutput
//  
//  This is a class to represent the setting for an environmental output. 
//  On the final, this class will remain as an interface to the different 
//  physical components, talking to them to determine if they should light 
//  up or express a value.
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/4/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//

class EnvironmentalOutput{
  String lineOne, lineTwo, lineThree;
  boolean sunny, windy, houseLight;
  float usedPower, reservePower;
  
  // Output given by whether it is sunny, windy, high power consumption, input strings, used power, and reserve power.
  public EnvironmentalOutput(boolean sunny, boolean windy, boolean houseLight, String lineOne, String lineTwo, String lineThree, float usedPower, float reservePower){
    this.sunny = sunny;
    this.windy = windy;
    this.houseLight = houseLight;
    this.lineOne = lineOne;
    this.lineTwo = lineTwo;
    this.lineThree = lineThree;
    this.usedPower = usedPower;
    this.reservePower = reservePower;
  }
  
  // SETTERS AND GETTERS DOWN BELOW.
  
  boolean isSunny(){
    return sunny;
  }
  
  boolean isWindy(){
    return windy;
  }
  
  boolean isHouseLightOn(){
    return houseLight;
  }
  
  String lineOne(){
    return lineOne;
  }
  
  String lineTwo(){
    return lineTwo;
  }
  
  String lineThree(){
    return lineThree;
  }
  
  float usedPower(){
    return usedPower;
  }
  
  float reservePower(){
    return reservePower;
  }
}