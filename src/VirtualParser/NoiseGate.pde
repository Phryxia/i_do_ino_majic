class NoiseGate
{
  int RELEASE_TIME;
  int flag;
  
  float peak;
  float decay;
  
  public NoiseGate(int _release_time, float _decay)
  {
    RELEASE_TIME = _release_time;
    flag         = RELEASE_TIME;
    
    peak  = 0.0f;
    decay = _decay;
  }
  
  boolean getTrigger(float x, float thr)
  {
    // Get ABS Value
    x = abs(x);
    
    // Envelope Follower
    if(x >= peak)
    {
      peak = x;
      if(peak > thr)
      {
        flag = RELEASE_TIME;
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      peak *= decay;
      if(peak > thr)
      {
        return true;
      }
      else
      {
        if(flag > 0)
        {
          --flag;
          return true;
        }
        else
        {
          return false;
        }
      }
    }
  }
}
