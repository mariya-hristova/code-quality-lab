#include <iostream>
using namespace std;

int main() {
    int x;
    cin >> x;
    if (x > 0) cout << "Positive\n";
    else if (x == 0) cout << "Zero\n";
    else cout << "Negative\n";

    if (x % 2 == 0) cout << "Even\n";
    else cout << "Odd\n";

    for (int i = 0; i < x; i++) {
        if (i % 3 == 0) cout << i << " divisible by 3\n";
    }
}
