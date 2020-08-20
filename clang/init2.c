#include <stdio.h>

static void init1() {
    printf("%s\n", __FUNCTION__);
}

static void init2() {
    printf("%s\n", __FUNCTION__);
}

typedef void (*init)();

__attribute__((section(".init_array"))) init init_arr[2] = {init1, init2};

int main(int argc, char *argv[]) {
    printf("hello!\n");

    return 0;    
}