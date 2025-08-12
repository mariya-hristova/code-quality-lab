#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            if (i % 5 == 0) {
                cout << i << " divisible by 2 and 5\n";
            }
        }
    }
}
