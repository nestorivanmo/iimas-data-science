#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
  pid_t pid; //revisa o investiga el tipo d variable pid_t
  int status, died;

  switch(pid = fork()) {
    case -1:
      printf("error... \n");
      exit(-1);
    case 0:
      printf("\t Código del hijo: %d\n", getpid());
      int i = 1;
      while (i<=10) {
        printf("\t\t Tarea del proceso hijo: %d\n", i++);
        sleep(1);
      }
      exit(20); // 256 * 20
    default:
      printf("Código del padre: \n");
      died = wait(&status);
      printf("Terminó el proceso hijo %d con status %d\n", died, status);
  }

  return (0);
}