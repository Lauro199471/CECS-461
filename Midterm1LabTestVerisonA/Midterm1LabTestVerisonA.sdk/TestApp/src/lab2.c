#include "xparameters.h"
#include "xgpio.h"
#include <stdio.h>
#include <unistd.h>

int main(void)
{

	XGpio dip , push;
	int statusDip,statusPush;
	int psb_check , dip_check;


	xil_printf("\t-- Start of the Program --\r\n");

	// Initialize the XGpio instance provided by the caller based on the given DeviceID. 
	statusDip  = XGpio_Initialize(&dip,XPAR_SWITCHES_DEVICE_ID);
	statusPush = XGpio_Initialize(&push,XPAR_BUTTONS_DEVICE_ID);
	if(statusDip == XST_SUCCESS && statusPush == XST_SUCCESS)
		print("XGpio_Initialize(DipSwitch && PushButton) = Success\n\r");
	else
	{
		print("XGpio_Initialize(DipSwitch || PushButton) = Failed\n\r");
		return XST_FAILURE;
	}
	// Set the direction for all signals to be outputs
	XGpio_SetDataDirection(&dip,  1 , 0xffffffff);
	XGpio_SetDataDirection(&push, 1 , 0xffffffff);

	while(1)
	{
		// Read the state of the Push Buttons
		psb_check = XGpio_DiscreteRead(&push,1);
		xil_printf("Push Buttons Status %x\r\n", psb_check);
		// Read the state of the Dip Switch
		dip_check = XGpio_DiscreteRead(&dip,1);
		xil_printf("Dip Switch Status %x\r\n", dip_check);
		sleep(1);
	}
} 

