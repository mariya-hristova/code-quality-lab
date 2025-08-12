#include <iostream>
using namespace std;

int main() {
    int n;
    cin >> n;
    int sum = 0;
    for (int i = 0; i < n; i++) sum += i;
    cout << "Sum=" << sum << endl;

    int prod = 1;
    for (int i = 1; i <= n; i++) prod *= i;
    cout << "Factorial=" << prod << endl;

    for (int i = n; i > 0; i--) cout << i << " ";
}
