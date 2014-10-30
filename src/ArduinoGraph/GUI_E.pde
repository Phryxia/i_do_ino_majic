/*
  This Class is Primitive Type of Container.
  Window will extends Container.
*/
public class GUI_E
{
  // Private:
  protected float x_size = 320.0;
  protected float y_size = 180.0;
  protected float x_bias = 0.0;
  protected float y_bias = 0.0;
  
  // Public:
  /*
    Constructor
  */
  
  /*
    Interface
  */
  void setSize(float _x_size, float _y_size)
  {
    x_size = _x_size;
    y_size = _y_size;
  }
  
  void setPos(float _x_bias, float _y_bias)
  {
    x_bias = _x_bias;
    y_bias = _y_bias;
  }
  
  void render() // This is abstract Method. It's useless to render this.
  {
    fill(0.0, 1.0, 1.0, 0.5);
    stroke(0.0, 1.0, 1.0);
    rect(x_bias, y_bias, x_size, y_size);
  }
}
