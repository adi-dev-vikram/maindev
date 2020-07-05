#include<iostream>
using namespace std;
#include<cstring>
#include<map>
#include<fstream>
#include <sstream>

int num;
// global value = 0
int main()
{
    
    // rearrange elements of given array in high and low manner
    // step 1: sort them in ascending order
    // step 2: intialize i = 0 and j=n-1
    // create a new aaray with k=0
    // a[k++] = b[i++]
    // a[k++] = b[j--]
    
    int arrNum[] = { 1,5,3,2,9,7};
    int n = sizeof(arrNum)/sizeof(int);
    sort(arrNum, arrNum+n);
    int k = 0;
    int* auxNewArray = new int[10];
    
    if (NULL==auxNewArray) {
        cout<< "Intialize failed"<<endl;
        return -1;
    }
    
    int i=0, j=n-1;
    while (i<j) {
        auxNewArray[k++]=arrNum[i++];
        auxNewArray[k++]=arrNum[j--];
    }
    for (int v=0; v<k; v++) {
        cout << *(auxNewArray+v)<<endl;
    }
    
    
    const char *pText = "FirstString" "SecondString";
    cout << pText <<endl;// same as std::string
    
    
    std::string newStr = "StringNumbaer";
    std::string concat = newStr + newStr;
    cout << concat << endl;
    // a byte is 8 bits
    constexpr size_t byte = 8;
    
    cout << num <<endl;
    
    printf("size of char is %ld bits\n And %ld for int", sizeof(char) * byte, sizeof(int)*byte);
    // char is 1 byte and int is 4 byte on macos ( might be diff)
    // for #include<cstdint> we get int8_t and others which are std size for all
    
    
    // use auto to deduce variables
    
    // auto ite = numbers.begin()
    // useful for complex objects
    
    
// Read Key-value pairs from config files
// For example: AuthServers=<IP>
    
    std::ifstream fs;
    fs.open("/Volumes/Data/Codebase/TestApp/agent.conf");
    if(fs.good())
    {
        printf("\nFile is there!");
    }
    else{
        printf("aditya");
    }
    std::map<std::string, std::string> ConfigInfo;

    std::string line;
    while (std::getline(fs, line))
    {
        std::istringstream is_line(line);
        std::string key;
        if (std::getline(is_line, key, '='))
        {
            std::string value;
            if (key[0] == '#')
                continue;
            
            if (std::getline(is_line, value))
            {
                ConfigInfo[key] = value;
                   cout <<  " The IP is: " << ConfigInfo[key] << endl;
            }
        }
    }
 
    return 0;
}