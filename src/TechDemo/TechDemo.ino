// ------------------------------------------------------------------------------------------- //
// -------------------------------------- Information ---------------------------------------- //
// ------------------------------------------------------------------------------------------- //
/*
  20141012 (Team) I Do Ino - Creative Engineering Class at SSU
  
  This program is prototype of Majik. (Algortihm Research)
*/

// ------------------------------------------------------------------------------------------- //
// -------------------------------------- Declaration ---------------------------------------- //
// ------------------------------------------------------------------------------------------- //
/*
  Cash Declaration
*/
int const N = 4;
double    cash_ori[N];
double    cash_dif[N];
void      c_init(void *cash);
void      c_assign(void *cash, int new_data);
double    c_getAverage(void *cash);

/*
  Detector Declaration
*/
boolean   state = false;
double    flag = 0.0;
double    threshold = 5.0;
boolean   isActive(double value);

/*
  Main Declaration
*/
int const LED = 13;
int const IDLE_LED = 12;
double    prev_byte = 0.0;
double    this_byte = 0.0;

// ------------------------------------------------------------------------------------------- //
// --------------------------------------- Main Part ----------------------------------------- //
// ------------------------------------------------------------------------------------------- //
int input_data; // Input Buffer
void setup()
{
  // Initialize Serial Port
  Serial.begin(9600);
  
  c_init(cash_ori);
  c_init(cash_dif);
  
  pinMode(LED, OUTPUT);
  pinMode(IDLE_LED, OUTPUT);
}

void loop()
{
  // Read Input Signal and Assign to the Cash
  input_data = analogRead(A0);
  c_assign(cash_ori, input_data);
  this_byte = c_getAverage(cash_ori);
  
  c_assign(cash_dif, this_byte-prev_byte);
  
  // LED Activation
  if(isActive(c_getAverage(cash_dif)))
  {
    digitalWrite(LED, HIGH);
    digitalWrite(IDLE_LED, LOW);
  }
  else
  {
    // Idle State
    digitalWrite(LED, LOW);
    digitalWrite(IDLE_LED, HIGH);
  }
  
  // Serial Export
  Serial.println(c_getAverage(cash_ori));
  prev_byte = this_byte;
  delay(10);
}

// ------------------------------------------------------------------------------------------- //
// -------------------------------------- Definition ----------------------------------------- //
// ------------------------------------------------------------------------------------------- //
/*
  Cash Definition
*/
void c_init(void *_cash)
{
  double *cash = (double *)_cash;
  for(int n=0; n<N; ++n)
  {
    cash[n] = 0.0;
  }
}

void c_assign(void *_cash, int new_data)
{
  // This moves datas in cash exactly one block.
  double *cash = (double *)_cash;
  for(int i=N-2; i>=0; --i)
  {  
    cash[i+1] = cash[i];
  }
  cash[0] = new_data;
}

double c_getAverage(void *_cash)
{
  // This calculate the
  double *cash = (double *)_cash;
  double temp = 0.0;
  for(int i=0; i<N; ++i)
  {
    temp += cash[i]*(N-i)/N;
  }
  temp /= N*0.5;
  
  return temp;
}

/*
  Detector Definition
*/
boolean isActive(double value)
{
  if(state)
  {
    // Active -> Deactive
    if(abs(value) < threshold)
    {
      if(flag <= 0.1)
      {
        // Release Time End
        state = false;
        flag = 0.0;
      }
      else
      {
        // Being Released
        flag *= 0.9;
      }
    }
    else
    {
      // Recover
      flag = 1.0;
    }
  }
  else
  {
    // Deactive -> Active
    if(abs(value) >= threshold)
    {
      state = true;
      flag = 1.0;
    }
  }
  
  return state;
}
