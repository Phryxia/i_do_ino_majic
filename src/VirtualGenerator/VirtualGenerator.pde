import processing.net.*;

/*
  This program generates random pseudo signal.
  You can access to this server with port 5204.
  Random int's will be generated.
  Helpful for I Do Ino's project : Majik.
*/
Server myServer;
void setup()
{
  size(400, 200);
  colorMode(HSB, 1.0);
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
void draw()
{
  // Make Random Event
  if(!isBusy)
  {
    if(cooltime < 0.1)
    {
      // Select Mode
      float dice = random(1);
      if(0 <= dice && dice < 0.7)
      {
        mode = 1;
      }
      else if(0.7 <= dice && dice < 1)
      {
        mode = 2;
      }
      cooltime = 1.0;
    }
    else
    {
      // Wait for the Cooltime
      mode = 0;
      cooltime *= random(0.95, 0.995);
    }
  }
  
  // Handle Each Event
  switch(mode)
  {
    default:
      data = int(2048*random(-1.0, 1.0));
      break;
    case 1:
      // Make Random Sinus Data
      if(!isBusy)
      {
        // Make Busy State On
        t = 0;
        size   = random(32768)+32768;
        freq   = random(0.2, 4.0);
        t_time = int(random(50, 150));
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
      
      freq += random(-0.02, 0.02);
      
      data = int(size*sin((freq)*TWO_PI*t/100.0)+250-random(500));
      break;
    case 2:
      // Make Random Impulse
      if(!isBusy)
      {
        t = 0;
        size  = random(32768)+32768;
        t_time = int(random(10)+10);
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
      
      data = int(size*exp(-2.0*t/t_time)+250-random(500));
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
  int ypos = int((0.5-data/131071.0)*height);
  if(0 <= ypos && ypos < height)
  {
    pixels[ypos*width+width-1] = color(0, 1, 1);
  }
  updatePixels();
  
  myServer.write(data); // -65536 ~ 65535
}
