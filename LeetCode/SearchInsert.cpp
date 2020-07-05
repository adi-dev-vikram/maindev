// Given a sorted array with distinct values search for a element 
//if not found then insert at the right place or return the index where we need to insert

#include <iostream>
#include <map>
using namespace std;


int SearchInsert(int Arr1[], int n, int target)
{
    if(n<1)
    {
        return 0;
    }

    int low=0;
    int high = n-1;
    int mid = low + (high - low)/2; 
    int pos=0;// Always use this for binary search

    if (Arr1[mid]==target)
    {
        return mid;
    }
    else if( Arr1[mid] > target)
    {
        high = mid -1;
        pos = mid;
    }
    else
    {
        low = mid +1;
        pos = mid +1;
    }
    return pos;
}



int main()
{
	// input keys
	int Arr1[] = {1,3,5,6,7 };
	int n = sizeof(Arr1) / sizeof(Arr1[0]);

    int target = 4;

    int returnElemnt = SearchInsert(Arr1,n,target);

    printf("\nThe pos is %d\n", returnElemnt);

    return 0;
}