/*
  CustomGUI.class provides some several tool to handle Arduino Scope GUI easily.
*/
void drawGrid(int _resolution)
{
  colorMode(HSB, 1.0);
    
  // Draw XY Line
  for(int i=0; i<10; ++i)
  {
    stroke(0, 1.0, 0.5);
    line(0, i*height/10, width, i*height/10);
  }
  
  stroke(0, 1.0, 1.0);
  line(0, height/2, width, height/2);
  line(0, 0, 0, height);
    
  // Draw Mini Ruler
  for(int i=0; i<_resolution; ++i)
  {
    line((float)i/_resolution*width, height/2-height*0.05, (float)i/_resolution*width, height/2+height*0.05);
  }
}
