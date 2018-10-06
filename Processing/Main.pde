//
//  Main
//
//  This is the Main, where the program is controlled.
//
//  Hegde_DB2
//
//  Created by Vikram Hegde on 11/11/17.
//  Copyright © 2017 Vikram Hegde. All rights reserved.
//

import processing.serial.*;

// These are the EnvironmentalOutputs that will be 
// displayed to the user over the course of the program.
// The outputs contain additional info like whats lights 
// light up and what text to display as seen in the boolean, 
// String, and in arrays. Please examine the array names to 
// understand what information each array holds.
EnvironmentalOutput[] environmentalOutputs = new EnvironmentalOutput[10];
String[] environmentalOutputsLineOnes = {"6:00 AM", "8:00 AM", "10:00 AM", "12:00 PM", "2:00 PM", "4:00 PM", "6:00 PM", "8:00 PM", "10:00 PM", "12:00 AM"};
String[] environmentalOutputsLineTwos = {"The sun is rising...", "The sun is up, the wind \nis starting to pick up", "The sun is up, \nit is a windy day.", "The wind is \nbeginning to go away.", "The wind is picking up again.", "The wind is dying down.", "The sun is setting. \nMore power is needed", "The wind is picking up.",  "The wind is still up. \nBuild as much storage as possible.", "Well done, you have saved enough energy"};
String[] environmentalOutputsLineThrees = {"Most people asleep... (LOW usage)", "Most people awake and \nusing energy (MEDIUM usage)", "Most people heading \nto work (LOW usage)", "Most people at work. (LOW usage)", "Most people at work. (LOW usage)", "Most people are beginning \nto head home. (LOW usage)", "Most people are relaxing \nat home. (MEDIUM usage)", "Most people are using \npower. (HIGH usage)", "Most people are headed \nto bed. (LOW usage)", "for the rest of the night."};
boolean[] environmentalOutputsSunny = {true, true, true, true, true, true, false, false, false, false};
boolean[] environmentalOutputsWindy = {false, true, true, false, true, false, false, true, true, false};
boolean[] environmentalOutputsHouse = {false, true, false, false, false, false, true, true, false, false};
float[] environementalOutputsUsedPower = {25, 60, 25, 25, 25, 25, 60, 100, 25, 0};
float[] environmentalOutputsReservePower = {0, 5, 0, 30, 35, 65, 70, 50, 15, 55};

// Here are the required inputs to pass each given output. 
// Once these are achieved the program moves to the next 
// output and waits for the next correct input. Please 
// examine the array names to understand what information 
// each array holds.
Input[] requiredInputs = new Input[10];
boolean[] requiredInputsSolarPower = {true,  true,  true,  true,  true,  true,  false, false, false, false};
boolean[] requiredInputsWindPower = { false, true,  true,  false, true,  false, false, true,  true,  false};
boolean[] requiredInputsCoalPower = { false, false, false, false, false, false, true,  true,  true,  false};
int[] requiredInputsThrowSwitch = {   1,     -1,    1,     1,     1,     1,     -1,    -1,    1,     0};

// Initialization of the Screen, OutputBoard, and 
// ControlPanel, the three interactive elements of 
// the program. The OutputBoard and ControlPanel 
// will be physical constructs on the final 
// iteration of the project.
Screen myScreen = new Screen();
OutputBoard myBoard = new OutputBoard();
ControlPanel myPanel = new ControlPanel();

// The index that controls what environmental condition 
// the user is on.
int environmentalOutputIndex = 0;

Serial myPort;
String val = "";
int previousWind = 1;
int previousSolar = 1;
int previousCoal = 1;
int previousSwitchUp = 1;
int previousSwitchDown = 1;
// Here is the code to interface with Adruino. 
// Please run Arduino program first.
// The previous variables are used to only 
// count once if the button is held

// Built in processing function. Run once at beginning of the program.
void setup(){
  fullScreen(); // sets the size of the window to ful screen
  background(0); // background to black
  textAlign(CENTER,CENTER); // all text is drawn from the center of their coordinates
  ellipseMode(CENTER); // as are all circles.
  frameRate(30);
  String portName = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  for(int i = 0; i < environmentalOutputs.length; i++){ 
    // initialize all outputs and required inputs using the arrays above.
    environmentalOutputs[i] = new EnvironmentalOutput(environmentalOutputsSunny[i], environmentalOutputsWindy[i], environmentalOutputsHouse[i], environmentalOutputsLineOnes[i], environmentalOutputsLineTwos[i], environmentalOutputsLineThrees[i], environementalOutputsUsedPower[i], environmentalOutputsReservePower[i]);
    requiredInputs[i] = new Input(requiredInputsSolarPower[i], requiredInputsWindPower[i], requiredInputsCoalPower[i], requiredInputsThrowSwitch[i]);
  }
}

// Built in function that loops after setup()
void draw(){
  serialRead();
  myPort.write(myPanel.getTimerText());
  println(myPanel.getTimerText());
  
  if(environmentalOutputIndex%environmentalOutputs.length == environmentalOutputs.length-1){ // on last element of array.
    myScreen.isLast(); // to change the last line of text
    myPanel.endTimer(); // end the timer to display the time to the user.
  }else{
    myScreen.isntLast(); // Do not change the last line of text
  }
  // The Board, Screen, and Panel are drawn here. This method loops, 
  // passing their coordinates and relevant info for them to function  
  myScreen.drawScreen(myPanel, environmentalOutputs[environmentalOutputIndex%environmentalOutputs.length], 10,10,width-20,height/2-20);
  myBoard.drawBoard(myPanel, environmentalOutputs[environmentalOutputIndex%environmentalOutputs.length], 10,height/2+10,width/2-20,height/2-20);
  myPanel.drawPanel(width/2+10,height/2+10,width/2-20,height/2-20);

  // This is true when the user enters correct inputs
  if(requiredInputs[environmentalOutputIndex%environmentalOutputs.length].isEqualInput(myPanel.getInput())){
    environmentalOutputIndex++; // next scenario
    if(environmentalOutputIndex%environmentalOutputs.length == 1){ // if the first scenario, start the timer.
      myPanel.startTimer();
      myPanel.resetTimer();
    }
  }

}

void serialRead(){
  if ( myPort.available() > 0){ 
    val = myPort.readStringUntil('\n'); // read to end of line and store it in val
  } 
  int currentWind = previousWind, currentSolar = previousSolar, currentCoal = previousCoal, currentSwitchDown = previousSwitchDown, currentSwitchUp = previousSwitchUp;
  // Sets the vvalues to unchanged when the program starts
  if(val != null && val.length() >=5 && val.indexOf("Switch")>=0){ // if we have a successful Serial connect
    currentSolar = int(val.substring(6,7));
    currentWind = int(val.substring(7,8));
    currentCoal = int(val.substring(8,9));
    currentSwitchUp = int(val.substring(9,10));
    currentSwitchDown = int(val.substring(10,11));
    // Read the values 0 if pressed, 1 if not pressed
  }
  println(val); //print it out in the console
  if(previousWind != currentWind && currentWind == 0)
    myPanel.windOn();
  if(previousSolar != currentSolar && currentSolar == 0)
    myPanel.solarOn();
  if(previousCoal != currentCoal && currentCoal == 0)
    myPanel.coalOn();
  if(previousWind != currentWind && currentWind == 1)
    myPanel.windOff();
  if(previousSolar != currentSolar && currentSolar == 1)
    myPanel.solarOff();
  if(previousCoal != currentCoal && currentCoal == 1)
    myPanel.coalOff();
  if(previousSwitchUp != currentSwitchUp && currentSwitchUp == 0)
    myPanel.switchUp();
  if(previousSwitchDown != currentSwitchDown && currentSwitchDown == 0)
    myPanel.switchDown();
  if(currentSwitchDown == currentSwitchUp)
    myPanel.switchMiddle();
  // Toggle all switches based on these read values.
    
  previousWind = currentWind;
  previousCoal = currentCoal;
  previousSolar = currentSolar;
  previousSwitchUp = currentSwitchUp;
  previousSwitchDown = currentSwitchDown;
  // Set the previous to the current so that 
  // we can see if the button is held or just changed.
}

// built in function the executes on key release
void keyReleased(){ // on key release, 
  if(key == 'a'){
    // solar switch
    myPanel.solarToggle();
  }
  
  if(key == 's'){
    // coal switch
    myPanel.coalToggle();
  }
  
  if(key == 'z'){
    // wind switch
    myPanel.windToggle();
  }
  
  if(keyCode == UP){
    // throw switch up
    myPanel.incrementSwitch();
  }
  
  if(keyCode == DOWN){
    // throw switch down
    myPanel.decrementSwitch();
  }
}