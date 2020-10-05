#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int main(void) {
	int pid;
	pid = fork();
	printf("pid: %d -> ", pid);
	if (pid == 0)
		printf("Child process \n");
	else
		printf("Parent process \n");
	return 0;
}	
