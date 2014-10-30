/*
  GUI_Graph plot the 1D datas on the Window.
*/
public class GUI_Graph
{
  private float x_size = 320.0;
  private float y_size = 180.0;
  private float x_bias = 0.0;
  private float y_bias = 0.0;
  private float x_zoom;
  private float y_zoom;
  private boolean automode = true;
  private float data_min;
  private float data_max;
  private Cash  data;
  
  /*
    Constructor
  */
  GUI_Graph(float _x_size, float _y_size, float _x_bias, float _y_bias)
  {
    setSize(_x_size, _y_size);
    setPos(_x_bias, _y_bias);
  }
  
  /*
    Method
  */
  public void init(int N)
  {
    data = new Cash(N);
  }
  
  public void setSize(float _x_size, float _y_size)
  {
    x_size = _x_size;
    y_size = _y_size;
  }
  
  public void setPos(float _x_bias, float _y_bias)
  {
    x_bias = _x_bias;
    y_bias = _y_bias;
  }
  
  public void setZoom(float _x_zoom, float _y_zoom)
  {
    x_zoom = _x_zoom;
    y_zoom = _y_zoom;
  }
  
  public void setRange(float _min, float _max)
  {
    if(!automode)
    {
      data_min = _min;
      data_max = _max;
    }
  }
  
  public void render()
  {
    // Draw Window
    colorMode(HSB, 1);
    stroke(0, 0.5, 0.5);
    fill(0, 1, 0.1, 0.5);
    rect(x_bias, y_bias, x_size, y_size);
    
    // Draw Grid
    stroke(0, 1, 1);
    line(xFunc(0, 1), yFunc(0.0), xFunc(1, 1), yFunc(0.0));
    
    // Draw Data
    stroke(0, 0, 1);
    fill(0, 0, 1);
    for(int i=0; i<data.getLength(); ++i)
    {
      float x_temp = xFunc(i, data.getLength());
      float y_temp = yFunc(data.getValue(i));
      
      ellipse(x_temp, y_temp, 1, 1);
    }
  }
  
  public void setMode(boolean _mode)
  {
    automode = _mode;
  }
  
  private float xFunc(float x, float x_max)
  {
    return x_bias + x*x_size/x_max;
  }
  
  private float yFunc(float y)
  {
    return y_bias + y_size*(1 - (y-data_min)/(data_max-data_min));
  }
}
