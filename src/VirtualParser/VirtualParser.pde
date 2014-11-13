import processing.net.*;

/*
  This program receive data from VirtualGenerator.pde
  You can access that server using port 5204.
  16bit signed int will be sent.
*/

Client myClient;
XParser myParser;
int data;
void setup()
{
  size(400, 400);
  colorMode(HSB, 1.0);
  background(0);
  myClient = new Client(this, "127.0.0.1", 5204);
  myParser = new XParser(1024);
  
  // Frame Rate = 100
  frameRate(100);
}
void draw()
{
  if(myClient.available() > 0)
  {
    data = readInt();
  }
  else
  {
    data = 0;
  }
  
  float noise_level = 4000;
  myParser.listen(data, noise_level);

  // Parsed Data
  noStroke();
  fill(0);
  rect(0, height/2, width, height);
  stroke(0, 1, 1);
  fill(0, 1, 1);
  for(int i=0; i<myParser.record_data_size; ++i)
  {
    ellipse(i/(float)myParser.record_data_size*width, 0.25*(3.0-myParser.record_data[i]/65536.0)*height, 1, 1);
  }
  
  // Buffer Monitor
  loadPixels();
  fast_rect(width-1, 0, width-1, height/2, color(0.33, 0.8, 0.5*myParser.gate.flag/myParser.gate.RELEASE_TIME));
  
  pixels[(int)constrain(0.25*height - 0.25*noise_level/65536*height, 0, height-1)*width + width-1] = color(0.8, 1, 1);
  pixels[(int)constrain(0.25*height + 0.25*noise_level/65536*height, 0, height-1)*width + width-1] = color(0.8, 1, 1);
  pixels[(int)constrain(0.25*height - 0.25*data/65536*height, 0, height-1)*width + width-1] = color(1);
  pixels[(int)constrain(0.25*height - 0.25*myParser.gate.peak/65536*height, 0, height-1)*width + width-1] = color(0, 1, 1);
  
  for(int y=0; y<height/2; ++y)
  {
    for(int x=0; x<width-1; ++x)
    {
      pixels[y*width+x] = pixels[y*width+x+1];
      pixels[y*width+x+1] = color(0);
    }
  }
  updatePixels();
}

int readInt()
{
  int buffer = 0;
  for(int i=0; i<4; ++i)
  {
    buffer |= (myClient.read() << (i*8));
  }
  return buffer;
}


