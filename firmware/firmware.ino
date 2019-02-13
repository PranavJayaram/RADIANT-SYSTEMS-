#include <HCMAX7219.h>
#include <SPI.h>
#include<EEPROM.h>
#include <bitBangedSPI.h>
#include <MAX7219_Dot_Matrix.h>
#include "cmddata.h"

#define rb

#ifdef lb
 #undef rb
#elif defined (rb)
  #undef lb
#endif

const byte chips = 10;
byte flag, b;
unsigned long lastMoved = 0, MOVE_INTERVAL = 50;  // mS
int  messageOffset;

#ifdef lb
  #define LOAD_4_lb 6
  #define LOAD_5 7
  #define dmxlb 5
  #define Bbid _lbid
  MAX7219_Dot_Matrix display_(chips, dmxlb);
  HCMAX7219 HCMAX7219_b(LOAD_4_lb), HCMAX7219_5(LOAD_5);
#elif defined (rb)
  #define LOAD_4_rb 7
  #define dmxrb 5
  #define Bbid _rbid
  MAX7219_Dot_Matrix display_(chips, dmxrb);  // Chips / LOAD
  HCMAX7219 HCMAX7219_b(LOAD_4_rb);
#endif
data bd;
void setup()
{
  delay(2000);
  Serial.begin(9600);
  display_.begin();
  EEPROM.get(0, bd);
  flag = 2;
}

void loop()
{
  //Serial.setTimeout(2000);
  while (Serial.available() == 0 && flag == 0);
  if (flag <= 1) //  means none of stored data is valid
  {
    flag = Serial.parseInt();
    //Serial.print("Bbid="); Serial.print(flag, DEC);
    //Serial.print(" Size of data: "); Serial.print(datasize, DEC);
    if (flag == Bbid)
    {
      Serial.println(valid_code);
     // Serial.readBytesUntil(3, (char *)&bd, datasize);
      Serial.readBytes((char *)&bd, datasize);
      Serial.println("0x80");
      EEPROM.put(0, bd);
       
    }
    else
      Serial.println(Bbid,DEC);
  }

  HCMAX7219_b.print7Seg_(bd.g4, 72);//g4s*4
  #ifdef lb
    HCMAX7219_5.print7Seg_(bd.g5, 72);//48+(g5s*8)
    HCMAX7219_5.Refresh();
  #endif
  HCMAX7219_b.Refresh();

  while (Serial.available() == 0)
  {
    if (millis() - lastMoved >= MOVE_INTERVAL)
    {
      display_.sendSmooth(bd.msgstr, messageOffset);
      // next time show one pixel onwards
      if (messageOffset++ >= (int)(bd.ml * 8))
        messageOffset = -chips * 8;
      lastMoved = millis();
    }
  }
  flag = 1;
}
