class XRecognizer
{
  int REF_SIZE = 128;
  float[][] REFERENCE;
  
  public XRecognizer()
  {
    REFERENCE = new float[5][REF_SIZE];
    for(int i=0; i<5; ++i)
    {
      for(int j=0; j<REF_SIZE; ++j)
      {
        if(i != 0)
        {
          REFERENCE[i][j] = sin(TWO_PI*i*j/REF_SIZE);
        }
        else
        {
          REFERENCE[i][j] = sin(PI*j/REF_SIZE);
        }
      }
    }
  }
  
  public float getSimilarity(float[] arr_a, float[] arr_b)
  {
    normalize(arr_a);
    normalize(arr_b);
    
    float mapping_rate;
    float similarity = 0.0f;
    
    // Seperation
    if(arr_a.length >= arr_b.length)
    {
      // Initializer
      mapping_rate = (float)arr_a.length/arr_b.length;
     
      for(int i=0; i<arr_a.length; ++i)
      {
        similarity += abs(arr_a[i] - arr_b[int(i/mapping_rate)])*(1- (i/mapping_rate - int(i/mapping_rate)));
      }
      similarity /= arr_a.length;
    }
    else
    {
      // Initializer
      mapping_rate = (float)arr_b.length/arr_a.length;
      
      for(int i=0; i<arr_b.length; ++i)
      {
        similarity += abs(arr_b[i] - arr_a[int(i/mapping_rate)]);
      }
      similarity /= arr_b.length;
    }
    
    return 1-similarity;
  }
  
  public int getMotion(float[] source)
  {
    println("Source Length : "+source.length);
    int state = -1; // IDLE
    float score = 0.0f;
    for(int i=0; i<5; ++i)
    {
      float data = abs(getSimilarity(source, REFERENCE[i]));
      if(data > score && data > 0.5f)
      {
        score = data;
        state = i;
      }
    }
    println("State : "+state+"("+(score*100)+"%)");
    
    return state;
  }
  
  public void normalize(float[] source)
  {
    float max = 0.0f;
    for(int i=0; i<source.length; ++i)
    {
      if(max < abs(source[i]))
      {
        max = abs(source[i]);
      }
    }
    if(max > 0.0f)
    {
      for(int i=0; i<source.length; ++i)
      {
        source[i] /= max;
      }
    }
  }
}
