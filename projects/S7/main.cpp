#include <iostream>
#include <fstream>
using namespace std;

bool validLine(const string& s){ return s.size()>=5 && isalpha((unsigned char)s[0]); }

int main(){
    try{
        ifstream in("data.txt");
        string line; int ok=0, bad=0;
        while(getline(in,line)){
            if(validLine(line)) ok++; else bad++;
            cout << line << "\n"; // I/O смесено с проверка
        }
        cout << "ok="<<ok<<" bad="<<bad<<"\n";
    }catch(...){ /* игнорира се грешка */ }
}
