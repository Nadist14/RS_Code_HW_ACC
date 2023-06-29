/* Example use of Reed-Solomon library 
 *
 * (C) Universal Access Inc. 1996
 *
 * This same code demonstrates the use of the encodier and 
 * decoder/error-correction routines. 
 *
 * We are assuming we have at least four bytes of parity (NPAR >= 4).
 * 
 * This gives us the ability to correct up to two errors, or 
 * four erasures. 
 *
 * In general, with E errors, and K erasures, you will need
 * 2E + K bytes of parity to be able to correct the codeword
 * back to recover the original message data.
 *
 * You could say that each error 'consumes' two bytes of the parity,
 * whereas each erasure 'consumes' one byte.
 *
 * Thus, as demonstrated below, we can inject one error (location unknown)
 * and two erasures (with their locations specified) and the 
 * error-correction routine will be able to correct the codeword
 * back to the original message.
 * */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdlib.h>
#include "ecc.h"


XTmrCtr_Config *tC;
XTmrCtr tI;

int prints_on = FALSE;
int HW_SLAVE_EN = 1;
int num_of_packets = 1;




unsigned char msg[223] = {0x00,  0x01,  0x02,  0x03,  0x04,
                       0x05,  0x06,  0x07,  0x08,  0x09,
                       0x0A,  0x0B,  0x0C,  0x0D,  0x0E,
                       0x0F,  0x10,  0x11,  0x12,  0x13,
                       0x14,  0x15,  0x16,  0x17,  0x18,
                       0x19,  0x1A,  0x1B};
unsigned char codeword[256];

/* Some debugging routines to introduce errors or erasures
   into a codeword.
   */

/* Introduce a byte error at LOC */
void
byte_err (int err, int loc, unsigned char *dst)
{
  printf("Adding Error at loc %d, data %#x\n", loc, dst[loc-1]);
  dst[loc-1] ^= err;
}

/* Pass in location of error (first byte position is
   labeled starting at 1, not 0), and the codeword.
*/
void
byte_erasure (int loc, unsigned char dst[], int cwsize, int erasures[])
{
  printf("Erasure at loc %d, data %#x\n", loc, dst[loc-1]);
  dst[loc-1] = 0;
}


void
print_word (int n, unsigned char *data) {
  int i;
  for (i=0; i < n; i++) {
    printf ("%02X ", data[i]);
  }
  printf("\n");
}

void tmrInit() {
	tC = XTmrCtr_LookupConfig(XPAR_TMRCTR_0_DEVICE_ID);
	XTmrCtr_Initialize(&tI,XPAR_TMRCTR_0_BASEADDR);
}

int
main (int argc, char *argv[])
{

  int erasures[16];
  int nerasures = 0;
  int time_val;

  char  decode_method[4] = {'S','W'};
  if(HW_SLAVE_EN)  decode_method[0] = 'H';

    /* Initialization the ECC library */
  initialize_ecc ();

  /* ************** */

#define ML (sizeof (msg) + NPAR)

  /* Now decode -- encoded codeword size must be passed */
  decode_data(codeword, ML);


  int fails = 0;
  tmrInit();
  XTmrCtr_Start(&tI,0);
  for (int z = 0; z < num_of_packets; z++) {
      int j;
      // make random msg data
      for (j=0; j<sizeof(msg); j++) {

          msg[j] = rand() % 256;
      }
      if(prints_on) printf("msg =");
      if(prints_on) print_word(223, msg);
      encode_data(msg, sizeof(msg), codeword);
      if(prints_on) printf("encoded data:\n");
      if(prints_on) print_word(ML, codeword);

      // add random errors to codeword

      int rloc_arr[NUM_OF_ERR] =  {0};
      unsigned char r_arr[NUM_OF_ERR] = {0};
      for (int i =0; i<NUM_OF_ERR; i++){
      unsigned char r = rand() % 256;
      int rloc = rand() % ML;
      codeword[rloc] = r;
      rloc_arr[i] = rloc;
      r_arr[i] = r;
      }

      if(prints_on){
     printf("encoded data with  errors:");
      for(int i=0;i<NUM_OF_ERR;i++){
        printf("%d @ loc %d ",r_arr[i], rloc_arr[i]);
              }
      print_word(ML, codeword);
      }
      /* Now decode -- encoded codeword size must be passed */
      decode_data(codeword, ML);
/*
      int group_1 [16] = {255,255,126,255,106,115,138,255,179,230,99,84,4,19,251,255};
        int group_2 [16] = {110,141, 81,86,244,88,173,29,90,96,212,20,161,137,214,217};
        int group_3 [16] = {2,99,91,247,0,223,34,124,121,0,37,177,195,208,0,79};
        for (int idx=0;idx<16;idx++){
              synBytes[idx] = group_1[idx];
         }
*/

      {
          int syndrome = check_syndrome ();
          if(prints_on) printf("syndrome = %d\n",syndrome);
          /* check if syndrome is all zeros */
          if (syndrome == 0) {
              // no errs detected, codeword payload should match message
              for (int k=0; k < sizeof(msg); k++) {
                  if (msg[k] != codeword[k]) {
                	  if(prints_on)  printf("#### FAILURE TO DETECT ERROR @ %d: %d != %d\n", k, msg[k], codeword[k]);
                      fails++;
                  }
              }

          } else {
        	  if(prints_on) printf("nonzero syndrome, attempting correcting errors\n");
              int result = 0;
              if(HW_SLAVE_EN) result =hw_correct_errors_erasures (codeword, ML,nerasures,erasures);
              else result =correct_errors_erasures (codeword, ML,nerasures,erasures);

              if(prints_on) printf("correct_errors_erasures = %d\n", result);
              if(prints_on) print_word(223, codeword);
              int k;
              for (k=0; k < sizeof(msg); k++) {
                  if (msg[k] != codeword[k]) {
                	  if(prints_on)  printf("##### FAILURE TO CORRECT ERROR @ %d: %d != %d\n", k, msg[k], codeword[k]);
                      fails++;
                  }
              }
          }
      }
  }
  XTmrCtr_Stop(&tI,0);

  if (fails == 0) {
      printf("\n\n All Tests Passed: No failures to correct codeword\n");
  } else {
      printf("### ERROR Algorithm failed to correct codeword %d times!!!\n", fails);
  }

  time_val = XTmrCtr_GetValue(&tI, 0);
  printf("\n\n Num of cycles for %d packets in %s: %u. \n\n",num_of_packets,decode_method,time_val);

  exit(0);
}

