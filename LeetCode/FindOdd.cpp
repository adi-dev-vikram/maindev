#include <iostream>
#include <map>
using namespace std;

// To find and remove element that occur odd number of times in array 

// here return 3

int OddFinder(int arr[], int x)
{
    // traverse and put in map if not there
    // then if value(num of occurence) in map %2 !=0 return it

    if(arr==0)
    {
        cout << "empty array"<< endl;
    }

    map<int, int> arrayNumMap; 
    auto itr = arrayNumMap.begin();
    for (int i=0; i<x; i++) { 
        auto it = arrayNumMap.find(arr[i]);
        if(it!=arrayNumMap.end())
        {
            arrayNumMap[arr[i]] += 1;
        }
        else{
            arrayNumMap[arr[i]]=1;
        }
    } 
    for (itr = arrayNumMap.begin(); itr != arrayNumMap.end(); ++itr) { 
        if((itr->second)%2!=0)
        {
            return itr->second;
        }
    } 
    cout << endl;
    return 0;  
}

int main()
{
	// input keys
	int keys[] = { 2, 2, 3, 4, 4,3,3 };
	int n = sizeof(keys) / sizeof(keys[0]);

    int oddNum = OddFinder(keys, n);
    cout << "The odd num is: "<< oddNum << endl;

    return 0;
}


