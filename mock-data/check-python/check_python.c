#include <stdio.h>  // printf(), fgets(), fputs(), ...
#include <string.h> // strcpy()

int main() {
    FILE *fp;
    char buffer[128];
    char version[128] = {0};
    FILE *log_fp;

    fp = popen("python3 --version","r"); // mo shell chay lenh python3 --version

    if (fgets(buffer, sizeof(buffer), fp)!=NULL){ // co ket qua luu vao version
        printf("Detected %s", buffer);
        strcpy(version, buffer);
    }
    else{                                         // khong co python3
        printf("Error: Python3 not found\n");
        strcpy(version, "Error: Python3 not found\n");
    }
    pclose(fp);
    
    log_fp = fopen("/tmp/python_ver.log","w"); // mo file python_ver.log va ghi
    if(log_fp!=NULL){
        fputs(version, log_fp);
        fclose(log_fp);
    }
    return 0;
}