#include <stdio.h>

static int global_static_var = 0;

static void local_func() {
}


__attribute__((weak)) int add(int a, int b) { 
    printf("warning: function is not implemented.\n"); 
    return 0;
}

int main(int argc, char *argv[]) {
    static int local_static_var = 0;

    printf("add(1,2) is %d\n", add(1,2));

    return 0; 
}