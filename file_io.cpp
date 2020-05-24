#include<iostream>
#include<fstream>
#include<string>
#include<map>

using namespace std;

#define ADC "hello bro"

std::string newFunc(std::string& str1)
{
    std::string newStr = str1;
    str1 = str1 + newStr;
    cout << "printing new func" << str1 << endl;
    return string("hi");
}

class Animal{
    int sum=0;
    std::string value;
    public:
        Animal()
        {
            printf("constructire called");
        }

        void getSum();
        ~Animal()
        {
            puts("destrutor");
        }
        void print() const;
};

void Animal::getSum(){
    printf( "the value of this is %p", this);
}


// prepro-> compiler->linker
int main(int argc, char* agv[])
{
    char x2;
    Animal* a1 = new Animal;
    a1->getSum();
    printf( "the value of this is %p", &a1);
    delete a1;
    size_t ybyte = sizeof(x2);
    cout << ybyte << endl;
    std::string age = "abx";
    auto x = newFunc(age);
    cout << age << endl;
    // for c string do x.c_str()
    cout << x << endl;

    std::string word = ADC;

    //cout << std::string(ADC) << endl;

    std::map<std::string, int> someMap;

    someMap["a"]=1;

    for(auto ite =someMap.begin() ; ite!=someMap.end(); ++ite)
    {
        cout << "printhign\t" << ite->second << endl;
    }
    ifstream infile;
    infile.open("agent.txt");

    ofstream outfile;
    outfile.open("newagent.txt", ios::out );

    string readdata;

    if(!infile.fail())
    {
        cout << "reading the data"<< endl;
        while(infile >> readdata)
        {
        cout << readdata << endl;
        }

    }
    infile.close();

}