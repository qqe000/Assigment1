#include <stdio.h>
#include <sys/time.h>
#include <time.h>

struct timeval stop, start;

// function that swaps elements
void swap(int *u, int *v)
{
  int t = *u;
  *u = *v;
  *v = t;
}

// function to find the position for partition (Hotspot)
int partition(int array[], int small, int big)
{  
  gettimeofday(&start, NULL);
  // makes the most right element pivot
  int pivot = array[big];
  
  // finds the element with the bigest value
  int i = (small - 1);

  // goes through each element comparing them with the pivot
  for (int j = small; j < big; j++)
  {
    if (array[j] <= pivot)
    {
        
      // if the element is found to be smaller than pivot it would be swaped by a greater element
      i++;
      
      // swaps element i with element j
      swap(&array[i], &array[j]);
    }
  }

  // swaps the pivot element with the greater element (i)
  swap(&array[i + 1], &array[big]);
  
  // return the point of partition
  return (i + 1);

  gettimeofday(&stop, NULL);
}

void quickSort(int array[], int small, int big)
{
  if (small < big)
  {
    
    // executes quick sort algorithim
    int pv = partition(array, small, big);

    // recursive call on the left of pivot
    quickSort(array, small, pv - 1);
    
    // recursive call on the right of pivot
    quickSort(array, pv + 1, big);
  }
}

// function to print elements
void printArray(int array[], int size)
{
  for (int i = 0; i < size; ++i)
  {
    printf("%d  ", array[i]);
  }

  printf("\n");

}

// main function
int main() 
{
  int dataset[] = {9, 4, 3, 1, 0, 7, 5};
  
  int n = sizeof(dataset) / sizeof(dataset[0]);
  
  printf("Unsorted Array\n");
  printArray(dataset, n);
  
  // perform quicksort on dataset
  quickSort(dataset, 0, n - 1);
  
  printf("Sorted array:\n");
  printArray(dataset, n);

  // benchmark partition function
  printf("Hotspot took: %lu millseconds\n", (stop.tv_sec - start.tv_sec) * 1000000 + stop.tv_usec - start.tv_usec);
}