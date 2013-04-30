char i;
int hwStatus;
int chStatus;

void main() { 


  CMCON = 7;       // Disable Comparators
  TRISA = 0;

  PORTA = 0;

  hwStatus = 0;
  chStatus = 0;
  Delay_ms(5000);                 // Wait for XBee to stabalize
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(500);                  // Wait for UART module to stabilize

  UART1_Write_Text(" Xbee Connection Successful! ");   // Character Message to be Sent
  UART1_Write(10);
  UART1_Write(13);


  while (1) {                     // Endless loop
        if (UART1_Data_Ready() == 1) {
            i = UART1_Read();                  // read the received data
            
            // Hot water
            if (i == 'h'){  // Set hot water on
                PORTA.B1 = 1;
                UART1_Write_Text("1");   // Character Message to be Sent
                UART1_Write(10);
                UART1_Write(13);
                hwStatus = 1;
            }
            if (i == 'i'){ // Set hot water off
                PORTA.B1 = 0;
                UART1_Write_Text("0");   // Character Message to be Sent
                UART1_Write(10);
                UART1_Write(13);
                hwStatus = 0;
            }
            if (i == 'j'){ // Check hot water status
               if (hwStatus == 1){
                  UART1_Write_Text("1");   // Character Message to be Sent
                  UART1_Write(10);
                  UART1_Write(13);
                }
                else{
                  UART1_Write_Text("0");   // Character Message to be Sent
                  UART1_Write(10);
                  UART1_Write(13);
                }
            }
            
            // Central Heating
            if (i == 'c'){    // set Central Heating on
                PORTA.B7 = 1;
                UART1_Write_Text("1");   // Character Message to be Sent
                UART1_Write(10);
                UART1_Write(13);
                chStatus = 1;
            }
            if (i == 'd'){   // set Central Heating off
                PORTA.B7 = 0;
                UART1_Write_Text("0");   // Character Message to be Sent
                UART1_Write(10);
                UART1_Write(13);
                chStatus = 0;
            }
            if (i == 'e'){  // check Central Heating status
               if (chStatus == 1){
                  UART1_Write_Text("1");   // Character Message to be Sent
                  UART1_Write(10);
                  UART1_Write(13);
                }
                else{
                  UART1_Write_Text("0");   // Character Message to be Sent
                  UART1_Write(10);
                  UART1_Write(13);
                }
            }

        }
  }

}