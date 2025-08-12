// trigger Codacy check

#include <iostream>
using namespace std;

int s(int a, int b) {
    return a+b;
}

int main() {
    int x=5, y=7;
    cout << s(x, y) << endl;
    return 0;
}
