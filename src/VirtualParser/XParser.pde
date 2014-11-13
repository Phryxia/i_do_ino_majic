class XParser
{
  // Public Field
  public float[] record_data;
  public int     record_data_size;

  // Inner Field
  private float[] buffer;
  private int     record_cnt;
  public  NoiseGate gate;

  // Constructor
  public XParser(int size)
  {
    record_data      = new float[size];
    record_data_size = 0;

    buffer           = new float[size];
    record_cnt       = 0;
    gate             = new NoiseGate(5, 0.8);
  }

  // Parsing Function
  public void listen(float x, float noise_level)
  {
    boolean doParse = false;
    if(gate.getTrigger(x, noise_level))
    {
      /*
        RECORDING DATA
       
        Push data into the buffer.
      */
      if(record_cnt < buffer.length)
      {
        buffer[record_cnt++] = x;
      }
      else
      {
        doParse = true;
      }
    }
    else
    {
      doParse = true;
    }

    if(doParse)
    {
      /*
        PARSING DATA
       
        Give array the parsed data.
      */
      if (record_cnt > 50)
      {
        // If Meaningness Value came, update record_data.
        record_data_size = record_cnt;
        float[] temp = new float[record_data_size];
        for (int i=0; i<record_data_size; ++i)
        {
          record_data[i] = buffer[i];
          temp[i] = buffer[i];
        }
        
        XRecognizer myRecognizer = new XRecognizer();
        myRecognizer.getMotion(temp);
      }
      record_cnt = 0;
    }
  }
}

