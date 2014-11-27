#include <SoftwareSerial.h>

SoftwareSerial BTSerial(0, 1);

int const LED_1 = 2;
int const LED_2 = 4;
int const LED_3 = 7;

int LED_STATE_1 = LOW;
int LED_STATE_2 = LOW;
int LED_STATE_3 = LOW;

long PREVIOUS_MILLIS = 0;
long interval = 300;
unsigned long CURRENT_MILLIS = 0;
int data = 0, temp = 0;

void LED_Pattern_1()
{
  if(CURRENT_MILLIS - PREVIOUS_MILLIS > interval)
  {
     PREVIOUS_MILLIS = CURRENT_MILLIS;
    
     if(LED_STATE_1 == LOW)
     {
       LED_STATE_1 = HIGH;
       LED_STATE_2 = LOW;
       LED_STATE_3 = HIGH;
     }
     else
     {
       LED_STATE_1 = LOW;
       LED_STATE_2 = HIGH;
       LED_STATE_3 = LOW;
     }
     digitalWrite(LED_1, LED_STATE_1);
     digitalWrite(LED_2, LED_STATE_2);
     digitalWrite(LED_3, LED_STATE_3);
  } 
}

void LED_Pattern_2()
{
   if(CURRENT_MILLIS - PREVIOUS_MILLIS > interval)
   {
     PREVIOUS_MILLIS = CURRENT_MILLIS;
    
     if(LED_STATE_2 == LOW && LED_STATE_3 == LOW)
     {
       LED_STATE_1 = LOW;
       LED_STATE_2 = HIGH;
       LED_STATE_3 = LOW;
     }
     else if(LED_STATE_1 == LOW && LED_STATE_3 == LOW)
     {
       LED_STATE_2 = LOW;
       LED_STATE_3 = HIGH;
       LED_STATE_1 = LOW;
     }
     else if(LED_STATE_1 == LOW && LED_STATE_2 == LOW)
     {
       LED_STATE_3 = LOW;
       LED_STATE_1 = HIGH;
       LED_STATE_2 = LOW;
     }
     digitalWrite(LED_1, LED_STATE_1);
     digitalWrite(LED_2, LED_STATE_2);
     digitalWrite(LED_3, LED_STATE_3);
   }
}

void LED_Pattern_3()
{
   if(CURRENT_MILLIS - PREVIOUS_MILLIS > interval)
  {
     PREVIOUS_MILLIS = CURRENT_MILLIS;
    
     if(LED_STATE_1 == LOW)
     {
       LED_STATE_1 = HIGH;
       LED_STATE_2 = LOW;
       LED_STATE_3 = HIGH;
     }
     else if(LED_STATE_2 == LOW)
     {
       LED_STATE_1 = HIGH;
       LED_STATE_2 = HIGH;
       LED_STATE_3 = LOW;
     }
     else if(LED_STATE_3 == LOW)
     {
       LED_STATE_1 = LOW;
       LED_STATE_2 = HIGH;
       LED_STATE_3 = HIGH;
     }
       
     digitalWrite(LED_1, LED_STATE_1);
     digitalWrite(LED_2, LED_STATE_2);
     digitalWrite(LED_3, LED_STATE_3);
  } 
}

void setup()
{
  BTSerial.begin(9600);
  pinMode(LED_1, OUTPUT);
  pinMode(LED_2, OUTPUT);
  pinMode(LED_3, OUTPUT);
}
void loop()
{
  CURRENT_MILLIS = millis();
  temp = data;
  while(BTSerial.available() > 0)
  {
    data = BTSerial.parseInt();
    if(data != temp)
    {
      LED_STATE_1 = LOW;
      LED_STATE_2 = LOW;
      LED_STATE_3 = LOW;
      digitalWrite(LED_1, LED_STATE_1);
      digitalWrite(LED_2, LED_STATE_2);
      digitalWrite(LED_3, LED_STATE_3);
    }
  }
  switch(data)
  {
    case 1:
      LED_Pattern_1();
      break;
    case 2:
      LED_Pattern_2();
      break;
    case 3:
      LED_Pattern_3();
      break;
    default:
      break;
  }
}
