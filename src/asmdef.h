#include <stdio.h>

extern int datasetsort(int dataset[],int length);
int main () {
    int dataset[] = {9, 4, 3, 1, 0, 7, 5};
    int length = 6;
    printf("Unsorted dataset: %d,%d,%d,%d,%d,%d,%d\n",dataset[0],dataset[1],dataset[2],dataset[3],dataset[4],dataset[5],dataset[6]);
    datasetsort(dataset,length);
    printf("Sorted dataset: %d,%d,%d,%d,%d,%d,%d\n",dataset[0],dataset[1],dataset[2],dataset[3],dataset[4],dataset[5],dataset[6]);

    return 0;
}