#ifndef MOTOR_SHIELD_H
#define MOTOR_SHIELD_H

#include "Arduino.h"

#define CH_A 0 // LEFT CHANNEL
#define CH_B 1 // RIGHT CHANNEL
#define FORWARD  0
#define BACKWARD 1
#define LEFT 0
#define RIGHT 1

/*
  RESET MOTOR SHILED DIGITAL IO
  
  i)  Don't Use Pin 3, 8, 9, 11, 12, 13. 
      This is pre-processed pin for Motor Shield
      
  ii) Place this function at void(setup). Please.
      Before you use these function, you have to
      initialize them.
*/
/*
  SYSTEM API
*/
void MS_init(void);
//static void MS_accel(int m_channel, int m_direction, int m_speed);
//static void MS_brake(int m_channel);

/*
  INTERFACE
  
  USE THIS. Don't use above code.
*/
void MS_go(void);
void MS_stop(void);
void MS_turn(int m_direction, float turn_speed);

void MS_setSpeed(int m_speed);

#endif
