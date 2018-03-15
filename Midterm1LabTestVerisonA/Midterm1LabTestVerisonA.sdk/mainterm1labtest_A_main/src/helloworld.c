#include <stdio.h>
#include "platform.h"
#include "xstatus.h"

// MUST INCLUDE THESE FILES
#include"xparameters.h"
#include"xgpio.h"

#define CHANNEL_1 1
#define INPUT 0xfffffff
#define OUTPUT 0x0
#define running 1

int main()
{
    XGpio pushButton,LED;// 2 drivers in this application LED and pushButton
    XStatus pushButton_check , LED_check; // Check to see if they are initilazed
    int pushButton_value;

    printf("Midterm test 1 Version A\n\r-Lauro Cabral");
	// Initilaze the GPIO driver so that it's ready to use
	pushButton_check = XGpio_Initialize(&pushButton,XPAR_PUSHBUTTON_MIDTERM1_VERSIONA_DEVICE_ID);
	LED_check = XGpio_Initialize(&LED,XPAR_LED_MIDTERM1_VERISONA_DEVICE_ID);

	// Check if they actually initialized
	// 1) Push Button Check
	if(pushButton_check == XST_SUCCESS)
		printf("\nPush Button: OK\n\r");
	else
	{
		printf("Push Button: FAIL\n\r");
		return XST_FAILURE;
	}
	// 2) LED Check
	if(LED_check == XST_SUCCESS)
		printf("LED: OK\n\r");
	else
	{
		printf("LED: FAIL\n\r");
		return XST_FAILURE;
	}
	// Set Direction
	// 1) Pushbutton: Input
	XGpio_SetDataDirection(&pushButton,CHANNEL_1,INPUT);
	// 2) LED: Output
	XGpio_SetDataDirection(&LED,CHANNEL_1,OUTPUT);

	while(running)
	{
		// Read the data from Push Button
		pushButton_value = XGpio_DiscreteRead(&pushButton,CHANNEL_1);
		// Send the data to LED
		XGpio_DiscreteWrite(&LED,CHANNEL_1,pushButton_value);
	}


    return 0;
}