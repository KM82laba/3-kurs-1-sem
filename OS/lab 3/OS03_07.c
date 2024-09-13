#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(){ 
    //child
    char *argv[] = {0};
    execv("./OS03_05_1", argv);
    //parent
    for (int i = 0; i < 100; i++) {
		printf("OS03_07 - PID: %d-#%d\n", getpid(), i);
		sleep(1);
	}

	return 0;
}