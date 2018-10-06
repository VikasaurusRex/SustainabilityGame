/*
 * Hegde_DB2
 * 
 * This is the Arduino portion of the code. 
 * It just prints the button states to Serial.
 *
 */
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int solarPin= A2;
int windPin = A1;
int coalPin = A0;
int throwUpPin = A3;
int throwDownPin = A4;
// Here are the pin values of each of the input buttons / throws
String val = "";

void setup() {
  Serial.begin(9600);
  // Begin at frequency 9600

  lcd.begin(16, 2); //Initialize the 16x2 LCD
  lcd.clear();  //Clear any old data displayed on the LCD
  
  int contrast_level=105;
  analogWrite(9, contrast_level);
}

void loop() {
  int solarVal = analogRead(solarPin);
  int windVal = analogRead(windPin);
  int coalVal = analogRead(coalPin);
  int throwUpVal = analogRead(throwUpPin);
  int throwDownVal = analogRead(throwDownPin);
  // Fin the Values based on of the switches and buttons are closed or open.

  if(solarVal < 525)
    solarVal = 0;
  else
    solarVal = 1;

  if(windVal < 525)
    windVal = 0;
  else
    windVal = 1;

  if(coalVal < 525)
    coalVal = 0;
  else
    coalVal = 1;

  if(throwUpVal < 525)
    throwUpVal = 0;
  else
    throwUpVal = 1;

  if(throwDownVal < 525)
    throwDownVal = 0;
  else
    throwDownVal = 1;

  lcd.setCursor(0, 1);  //Set the (invisible) cursor to column 0,
              // row 1.
  lcd.print(millis()/1000); //Print to see if it work
  
//      val = Serial.read(); // read it and store it in val
//      if(val.indexOf("Time")>=0){
//        lcd.setCursor(0, 1);  //Set the (invisible) cursor to column 0,
//              // row 1.
//        lcd.print(val); //Print the number of seconds
//                //since the Arduino last reset.
//      }

  Serial.println("Switch" + String(solarVal) + String(windVal) + String(coalVal) + String(throwUpVal) + String(throwDownVal));
  // Print to the Serial to be read in Processing
  delay(50);
  // delay so there is less spam
}

