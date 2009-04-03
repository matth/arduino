/**
 * Merge RGB led to (hopefully) diffuse into a new colour.
 *
 * Arduino listens on serial port for colour values
 *
 * EG: R043~ - Will set the Red LED to 43 the "~" is a special character that signifies the end of a command
 *   
 *     R012~G255~B053~
 * 
 * @author matth - Apr 2008
 */

#include <string.h>

int aPin = 9;         // light connected to digital pin 9  - Red
int bPin = 10;        // light connected to digital pin 10 - Green
int cPin = 11;        // light connected to digital pin 11 - Blue

int aVal = 255;     // RED
int bVal = 0;     // GREEN
int cVal = 4;      // BLUE

int curPin = aPin;

char* stringIn = "000";
char charIn = 0;  
byte i = 0;

void setup() { 

  // Set data rate for incoming serial transmission
  Serial.begin(9600);

  // Set initial colour
  analogWrite(aPin, aVal);           // sets the value (range from 0 to 255)   
  analogWrite(bPin, bVal);           // sets the value (range from 0 to 255)     
  analogWrite(cPin, cVal);           // sets the value (range from 0 to 255)       

} 

void loop() { 

  if (Serial.available() > 0) {

    charIn = nextByte();

    if (charIn == 126) {

      int curVal = atoi(stringIn);    

      analogWrite(curPin, curVal);           // sets the value (range from 0 to 255)               

      // Reset 
      stringIn = "000";
      curVal = 0;
      i = 0;

    } 
    else if (charIn == 82) {  // RED
      curPin = aPin;          
    } 
    else if (charIn == 71) {  // GREEN
      curPin = bPin;
    } 
    else if (charIn == 66) {  // BLUE
      curPin = cPin;          
    } 
    else if (charIn >= 48 && charIn <=57) { // We have a number to parse       
      stringIn[i] = charIn;
      i += 1;        
    }                
  }        
}

/**
 *  Reads byte from serial in
 * @returns {byte} The byte read from serial connection 
 */
byte nextByte() {
  while(1) {
    if(Serial.available() > 0) {
      byte b =  Serial.read();
      return b;
    }
  }
}

