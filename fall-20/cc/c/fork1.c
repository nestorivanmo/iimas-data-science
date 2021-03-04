#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>

int main(void) {
	int fpid;
	fpid = fork();
	printf("ID del proceso: %d\n", fpid);
	if (fpid == 0)
		printf("\tProceso hijo \n");
	else
		printf("\tProceso padre \n");
	return (0);
}
