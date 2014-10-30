public class Cash
{
  /*
    This class provide 'Ring Register'. (Because it have to calculate fastly)
  */
  public float[] data;
  int start_pos = 0;
  
  /*
    Constructor
  */
  Cash(int _N)
  {
    data = new float[_N];
  }
  
  void assignCash(float new_data)
  {
    data[start_pos] = new_data;
    
    if(++start_pos >= data.length)
    {
      start_pos = 0;
    }
  }
  
  public float getValue(int _index)
  {
    return data[(_index+start_pos)%data.length];
  }
  
  public float getAverage()
  {
    float temp = 0.0;
    for(int i=0; i<data.length; ++i)
    {
      temp += data[i]*(data.length-i)/data.length;
    }
    temp /= data.length*0.5;
  
    return temp;
  }
  
  public int getLength()
  {
    return data.length;
  }
}
