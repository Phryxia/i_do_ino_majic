void fast_rect(float x1, float y1, float x2, float y2, color c)
{
  // Convienient Swap
  if(x1 > x2)
  {
    float temp = x1;
    x1 = x2;
    x2 = temp;
  }
  if(y1 > y2)
  {
    float temp = y1;
    y1 = y2;
    y2 = temp;
  }
  
  // Boundary Protection
  if(x1 < 0)
  {
    x1 = 0;
  }
  else if(x1 >= width)
  {
    return;
  }
  if(x2 < 0)
  {
    return;
  }
  else if(x2 >= width)
  {
    x2 = width-1;
  }
  
  if(y1 < 0)
  {
    y1 = 0;
  }
  else if(y1 >= height)
  {
    return;
  }
  if(y2 < 0)
  {
    return;
  }
  else if(y2 >= height)
  {
    y2 = height-1;
  }
  
  // Draw
  for(int y=(int)y1; y<=(int)y2; ++y)
  {
    for(int x=(int)x1; x<=(int)x2; ++x)
    {
      pixels[y*width + x] = c;
    }
  }
}
