#include "Arduino.h"
#include "MotorShield.h"

static int current_speed   = 0;
static int current_speed_l = 0;
static int current_speed_r = 0;

/*
  RESET MOTOR SHILED DIGITAL IO
  
  i)  Don't Use Pin 3, 8, 9, 11, 12, 13. 
      This is pre-processed pin for Motor Shield
      
  ii) Place this function at void(setup). Please.
      Before you use these function, you have to
      initialize them.
*/
void MS_init(void)
{
  // MS PWM
  pinMode(3 , OUTPUT);
  pinMode(11, OUTPUT);
  
  // BRAKE
  pinMode(9, OUTPUT);
  pinMode(8, OUTPUT);
  
  // DIRECTION
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
}

/*
  ABOUT MS_ACCEL
  
  This will turn on motor.
  Brake will be break. (Unlock brake as LOW)
*/
void MS_accel(int m_channel, int m_direction, int m_speed)
{
  if(m_channel)
  {
    // CH_B
    if(m_direction)
    {
      // BACKWARD
      digitalWrite(13, LOW);
    }
    else
    {
      // Forward
      digitalWrite(13, HIGH);
    }
    digitalWrite(8 , LOW);
    digitalWrite(11, m_speed);
  }
  else
  {
    // CH_A
    if(m_direction)
    {
      // BACKWARD
      digitalWrite(12, LOW);
    }
    else
    {
      // Forward
      digitalWrite(12, HIGH);
    }
    digitalWrite(9, LOW);
    digitalWrite(3, m_speed);
  }
}

/*
  ABOUT MS_BRAKE
  
  This will stop your motor.
*/
void MS_brake(int m_channel)
{
  if(m_channel)
  {
    // CH_B
    digitalWrite(8, HIGH);
  }
  else
  {
    // CH_A
    digitalWrite(9, HIGH);
  }
}

void MS_go(void)
{
  MS_accel(CH_A, FORWARD, current_speed_l);
  MS_accel(CH_B, FORWARD, current_speed_r);
}

void MS_stop(void)
{
  MS_brake(CH_A);
  MS_brake(CH_B);
}

/*
  ABOUT TURN
*/
void MS_turn(int m_direction, float turn_speed)
{
  if(m_direction)
  {
    // RIGHT
    current_speed_r = current_speed;
    current_speed_l = (int)(current_speed*(1.0f-turn_speed));
  }
  else
  {
    // LEFT
    current_speed_r = (int)(current_speed*(1.0f-turn_speed));
    current_speed_l = current_speed;
  }
}

void MS_setSpeed(int m_speed)
{
  current_speed = m_speed;
}
