#include <stdio.h>

int main(int argc, char *argv[]) {
    int i = 2;
    int c = add(1, 2);
    printf("c = %d\n", c);
    asm("int 3");
    printf("Hello World\n");
    return 0; 
}
