#include "MotorShield.h"

int t = 0;
void setup()
{
  MS_init();
  pinMode(10, OUTPUT);
}

int gostop = 1;

void loop()
{
  if(gostop == 1)
  {
    MS_go();
  }
  else
  {
    MS_stop();
  }
  MS_setSpeed(t);
  MS_setDirection(t/255.0f);
  
  analogWrite(10, t);
  
  if(t == 255)
  {
    t = 0;
    gostop = 1-gostop;
  }
  else
  {
    ++t;
  }
  delay(10);
}
