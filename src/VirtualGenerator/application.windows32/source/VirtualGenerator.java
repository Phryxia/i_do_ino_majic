import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class VirtualGenerator extends PApplet {



/*
  This program generates random pseudo signal.
  You can access to this server with port 5204.
  Random int's will be generated.
  Helpful for I Do Ino's project : Majik.
*/
Server myServer;
public void setup()
{
  size(400, 200);
  colorMode(HSB, 1.0f);
  background(0);
  myServer = new Server(this, 5204);
  
  // Frame Rate = 100
  frameRate(100);
}

int mode = 0;
int data = 0;
float size = 0;
float freq = 0;
int t    = 0;
int t_time = 0;
boolean isBusy = false;
float cooltime = 1;
float temp_cooltime = 1;
public void draw()
{
  // Make Random Event
  if(!isBusy)
  {
    if(cooltime < 0.1f)
    {
      // Select Mode
      float dice = random(1);
      if(0 <= dice && dice < 0.7f)
      {
        mode = 1;
      }
      else if(0.7f <= dice && dice < 1)
      {
        mode = 2;
      }
      cooltime = 1.0f;
    }
    else
    {
      // Wait for the Cooltime
      mode = 0;
      cooltime *= random(0.95f, 0.995f);
    }
  }
  
  // Handle Each Event
  switch(mode)
  {
    default:
      data = PApplet.parseInt(2048*random(-1.0f, 1.0f));
      break;
    case 1:
      // Make Random Sinus Data
      if(!isBusy)
      {
        // Make Busy State On
        t = 0;
        size   = random(32768, 65535);
        freq   = random(0.2f, 4.0f);
        t_time = PApplet.parseInt(random(50, 150));
        isBusy = true;
      }
      else
      {
        // Busy State Off when time done
        if(t >= t_time)
        {
          isBusy = false;
        }
        ++t;
      }
      
      freq += random(-0.02f, 0.02f);
      
      data = PApplet.parseInt(size*sin((freq)*TWO_PI*t/100.0f)+250-random(500));
      break;
    case 2:
      // Make Random Impulse
      if(!isBusy)
      {
        t = 0;
        size  = random(32768, 65535);
        t_time = PApplet.parseInt(random(10)+10);
        isBusy = true;
      }
      else
      {
        if(t >= t_time)
        {
          isBusy = false;
        }
        ++t;
      }
      
      data = PApplet.parseInt(size*exp(-2.0f*t/t_time)+250-random(500));
      break;
  }
  
  // Rendering
  loadPixels();
  //   Shift to left side
  for(int y=0; y<height; ++y)
  {
    for(int x=0; x<width-1; ++x)
    {
      pixels[y*width+x] = pixels[y*width+x+1];
    }
    pixels[y*width+width-1] = color(0);
  }
  int ypos = PApplet.parseInt((0.5f-data/131071.0f)*height);
  if(0 <= ypos && ypos < height)
  {
    pixels[ypos*width+width-1] = color(0, 1, 1);
  }
  updatePixels();
  
  writeInt(data); // -65536 ~ 65535
}

public void writeInt(int x)
{
  for(int i=0; i<4; ++i)
  {
    myServer.write(x & 0xFF);
    x >>= 8;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "VirtualGenerator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
