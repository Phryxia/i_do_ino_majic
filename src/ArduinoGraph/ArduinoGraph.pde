// ------------------------------------------------------------------------------------------- //
// -------------------------------------- Information ---------------------------------------- //
// ------------------------------------------------------------------------------------------- //
/*
  20141012 (Team) I Do Ino - Creative Engineering Class at SSU
  
  This program is Oscilloscope for Majik. (Algortihm Research)
*/

import processing.serial.*;
Serial myPort;        // The serial port
int xPos = 1;         // horizontal position of the graph

float inByte   = 0.0;
float prevByte = 0.0;
String inString;

// ------------------------------------------------------------------------------------------- //
// --------------------------------------- Main Part ----------------------------------------- //
// ------------------------------------------------------------------------------------------- //

void setup()
{
  // set the window size:
  size(640, 320);        
 
  // List all the available serial ports
  println(Serial.list());
  
  // I know that the first port in the serial list on my mac
  // is always my  Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set inital background:
  background(0);
  colorMode(HSB, 1.0);
  frameRate(100);
}

void draw()
{
}

Cash cash_ori = new Cash(400);
void serialEvent(Serial myPort)
{
  // get the ASCII string:
  inString = myPort.readStringUntil('\n');
  if(inString != null)
  {
    // at the edge of the screen, go back to the beginning:
    if(xPos >= width)
    {
      xPos = 0;
    }
    else
    {
      // increment the horizontal position:
      xPos++;
    }
    // convert to an int and map to the screen height:
    inByte = map(float(trim(inString)), 0, 1023, 0, height);
    
    // Assign Cash
    cash_ori.assignCash(inByte);
    //cash_dif.assignCash(inByte - prevByte);
    
    background(0);
    stroke(0, 1, 1);
    for(int i=0; i<cash_ori.getLength(); ++i)
    {
      ellipse((float)i/cash_ori.getLength()*width, height - height*cash_ori.getValue(i)/1024, 1, 1);
    }
    
    prevByte = inByte;
  }
}
