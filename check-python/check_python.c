#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *fp;
    char buffer[128];
    char version[128] = {0};
    FILE *log_fp;

    fp = popen("python3 --version","r");

    if (fgets(buffer, sizeof(buffer), fp)!=NULL){
        printf("Detected %s", buffer);
        strcpy(version, buffer);
    }
    else{
        printf("Error: Python3 not found\n");
        strcpy(version, "Error: Python3 not found\n");
    }
    pclose(fp);
    
    log_fp = fopen("/tmp/python_ver.log","w");
    if(log_fp!=NULL){
        fputs(version, log_fp);
        fclose(log_fp);
    }
    return 0;
}