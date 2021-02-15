#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
	int i = 1;
	switch(fork()) {
		case -1:
			perror("Error al crear el proceso");
			exit(-1);
			break;
		
		case 0:
			while(i<=10) {
				sleep(1);
				printf("\t Soy el proceso hijo: %d\n", i++);
			}
			break;
	
		default:
			while(i<=10){
				printf("Soy el proceso padre: %d\n", i++);
				sleep(2);
			}
	}	
	return (0);
}
