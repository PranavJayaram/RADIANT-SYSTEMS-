/*
Author :Manu Hegde, gk1010100@gmail.com
11/05/2017
*/
#ifndef _CMDDATA_
#define _CMDDATA_

#define maxg4 18
#define maxg5 2
#define g4maxlen ((maxg4*4)+1)
#define g5maxlen ((maxg5*8)+1) //8 because 3 spaces are to be added at for every 5 nums
#define datastructsize 400
#define msglen (datastructsize-3-g4maxlen-g5maxlen-2)

//both lbid and rbid should be such values that they do not have any common bit set
#define _lbid 1
#define _rbid 2  // THESE VALUES are index boards in dps +1
#define valid_code "0x45"

//#define cmd_readdata 92

#ifdef _MSVC_LANG 
#define PACKED
#pragma pack(push,1)
#else
#define PACKED __attribute__ ((__packed__))
#endif

struct data
{
  //unsigned char bid;//3MSB will contain no of g5,rest of bytes on how many g4
  unsigned char gs4 : 5;
  unsigned char gs5 : 3;
  short ml : 12;
  short bid : 4;
  char g4[g4maxlen];
  char g5[g5maxlen];
  char msgstr[msglen];
  char sig[2];
} PACKED; //size is 300 bytes
#undef PACKED

#ifdef _MSVC_LANG 

#pragma pack(pop)

union du
{
  struct data d;
  unsigned char b[sizeof(data)];
  void display(int hexdump = 0);
};
#endif
#define datasize ((int)sizeof(data))
#endif
