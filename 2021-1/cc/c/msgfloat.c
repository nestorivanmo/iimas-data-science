#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
  int pid, pipefd[2];
  float x, y;
  pipe(pipefd);
  pid = fork();
  if (pid) {
    close(pipefd[0]);
    printf("\n Soy el padre (%d), dame un número real:", getppid());
    scanf("%f", &x);
    write(pipefd[1], &x, sizeof(float));
  } else {
    printf("\n Soy el hijo (%d), ", getpid());
    close(pipefd[1]);
    read(pipefd[0], &y, sizeof(float));
    printf(" mensaje recibido: %f", y);
  }
  return (0);
}