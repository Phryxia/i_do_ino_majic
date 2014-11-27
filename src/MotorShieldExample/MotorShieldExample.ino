#include "MotorShield.h"
int x = 0;
float u = 0.0f;
void setup()
{
  MS_init();
}

void loop()
{
  MS_go();
  MS_setSpeed(x = (x+1)%255);
  MS_turn(LEFT, u);
  
  if(u < 1.0f)
  {
    u += 0.01f;
  }
  else
  {
    u = 0.0f;
  }
}
