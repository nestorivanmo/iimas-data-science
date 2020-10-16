#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/*
  Programa que calcula el producto de dos números y obtiene el mayor entre esos dos mismos números. 
  Dichas operaciones las hace un proceso diferente. 
*/
int main(void) {
  int i;
  int a, b;
  pid_t pidh1, pidh2, pidx;
  int prod, mayor;
  int res;

  printf("\nDame dos enteros: \n");
  scanf("%d%d", &a, &b);
  pidh1 = fork(); 

  /*
    - El hijo de pidh1 regresará el producto de a y b
    - El hijo de pidh2 regresará el mayor entre a y b
    - pidh2 entra en un ciclo de 2 para esperar al resultado de su hijo y del hijo de pidh1
    - pidh2 asigna los valores a 'prod' y 'mayor' dependiendo del ppid
    - pidh2 imprime los valores de 'prod' y 'mayor'
  */
  
  if(pidh1) {
    pidh2 = fork();
    if(pidh2) {
      for(i = 0; i < 2; i++){
        pidx = wait(&res);
        if (pidx == pidh1) {
          prod = res;
        } else {
          mayor = res;
        }
      }
      printf("\n El producto de %d y %d es %d\n", a, b, prod >> 8);
      printf("\n El mayor de %d y %d es %d \n", a, b, mayor >> 8);
    } else {
      if(a > b) {
        exit(a);
      } else {
        exit(b);
      }
    }
  } else { 
    prod = a * b;
    exit(prod);
  }

  return(0);
 }
