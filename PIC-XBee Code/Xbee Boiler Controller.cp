#line 1 "E:/Development/Electronics/Solar Monitor/Xbee Boiler Controller/code/Xbee Boiler Controller.c"
char i;
int hwStatus;
int chStatus;

void main() {


 CMCON = 7;
 TRISA = 0;

 PORTA = 0;

 hwStatus = 0;
 chStatus = 0;
 Delay_ms(5000);
 UART1_Init(9600);
 Delay_ms(500);

 UART1_Write_Text(" Xbee Connection Successful! ");
 UART1_Write(10);
 UART1_Write(13);


 while (1) {
 if (UART1_Data_Ready() == 1) {
 i = UART1_Read();


 if (i == 'h'){
 PORTA.B1 = 1;
 UART1_Write_Text("1");
 UART1_Write(10);
 UART1_Write(13);
 hwStatus = 1;
 }
 if (i == 'i'){
 PORTA.B1 = 0;
 UART1_Write_Text("0");
 UART1_Write(10);
 UART1_Write(13);
 hwStatus = 0;
 }
 if (i == 'j'){
 if (hwStatus == 1){
 UART1_Write_Text("1");
 UART1_Write(10);
 UART1_Write(13);
 }
 else{
 UART1_Write_Text("0");
 UART1_Write(10);
 UART1_Write(13);
 }
 }


 if (i == 'c'){
 PORTA.B7 = 1;
 UART1_Write_Text("1");
 UART1_Write(10);
 UART1_Write(13);
 chStatus = 1;
 }
 if (i == 'd'){
 PORTA.B7 = 0;
 UART1_Write_Text("0");
 UART1_Write(10);
 UART1_Write(13);
 chStatus = 0;
 }
 if (i == 'e'){
 if (chStatus == 1){
 UART1_Write_Text("1");
 UART1_Write(10);
 UART1_Write(13);
 }
 else{
 UART1_Write_Text("0");
 UART1_Write(10);
 UART1_Write(13);
 }
 }

 }
 }

}
