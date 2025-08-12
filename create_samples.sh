#!/usr/bin/env bash
set -e

mkdir -p S1/src S2/src S3/src S4/src S5/src S6/src S7/src

# ========== S1: Чист и четим код (очаквано добри метрики) ==========
cat > S1/README.md <<'MD'
S1 — чист пример: малки функции, коментари, разделяне на отговорностите.
MD

cat > S1/src/main.cpp <<'CPP'
#include <iostream>
#include <vector>
#include <numeric>

// Връща средна стойност; предпазва от деление на нула.
double average(const std::vector<int>& v) {
    if (v.empty()) return 0.0;
    long long sum = std::accumulate(v.begin(), v.end(), 0LL);
    return static_cast<double>(sum) / static_cast<double>(v.size());
}

int main() {
    std::vector<int> data = {1, 2, 3, 4, 5};
    std::cout << "avg=" << average(data) << "\n";
    return 0;
}
CPP

# ========== S2: Висока цикломатична сложност (дълга функция с много клонове) ==========
cat > S2/README.md <<'MD'
S2 — демонстрация на висока цикломатична сложност в една функция.
MD

cat > S2/src/main.cpp <<'CPP'
#include <iostream>
#include <string>

int scoreCategory(int x, const std::string& s) {
    int score = 0;
    if (x > 100) score += 3; else score -= 1;
    if (x % 2 == 0) score += 2; else score -= 2;
    if (x < 0) score -= 5; else score += 1;

    if (s == "alpha") score += 4;
    else if (s == "beta") score += 3;
    else if (s == "gamma") score += 2;
    else if (s == "delta") score += 1;
    else score -= 1;

    switch (x % 5) {
        case 0: score += 1; break;
        case 1: score += 2; break;
        case 2: score += 3; break;
        case 3: score += 4; break;
        case 4: score += 5; break;
    }

    if (x > 50 && x < 60) score += 5;
    if (x > 60 && x < 70) score += 5;
    if (x > 70 && x < 80) score += 5;
    if (x > 80 && x < 90) score += 5;
    if (x > 90 && x < 100) score += 5;

    return score;
}

int main() {
    std::cout << scoreCategory(73, "beta") << "\n";
    return 0;
}
CPP

# ========== S3: Дублиране на код (почти идентични функции) ==========
cat > S3/README.md <<'MD'
S3 — умишлено дублиране на почти идентична логика.
MD

cat > S3/src/main.cpp <<'CPP'
#include <iostream>
#include <vector>

int sumA(const std::vector<int>& v){
    int s=0;
    for(int i=0;i<(int)v.size();++i){
        s+=v[i];
    }
    return s;
}

int sumB(const std::vector<int>& v){
    int s=0; // почти същата реализация като sumA
    for(int i=0;i<(int)v.size();++i){
        s+=v[i];
    }
    return s;
}

int main(){
    std::vector<int> x={1,2,3};
    std::cout<< sumA(x) + sumB(x) <<"\n";
    return 0;
}
CPP

# ========== S4: Стилови нарушения (lint): липса на интервали, дълги редове, кратки имена ==========
cat > S4/README.md <<'MD'
S4 — стилови проблеми: липсващи интервали, дълги редове, еднобуквени имена.
MD

cat > S4/src/main.cpp <<'CPP'
#include <iostream>
using namespace std;int f(int a,int b){if(a>b){return a+b;}else{return a-b;}}int main(){int x=5;int y=3;cout<<"res="<<f(x,y)<<" very very very very very very very very very very very very very very very very very very long line to trigger linters\n";return 0;}
CPP

# ========== S5: Дълги функции и вложени цикли (гранична сложност) ==========
cat > S5/README.md <<'MD'
S5 — вложени цикли и няколко клонове, без фатални грешки, но по-ниска четимост.
MD

cat > S5/src/main.cpp <<'CPP'
#include <iostream>
#include <vector>

int heavy(const std::vector<std::vector<int>>& m){
    int acc = 0;
    for(size_t i=0;i<m.size();++i){
        for(size_t j=0;j<m[i].size();++j){
            int v=m[i][j];
            if(v%2==0){ acc+=v; } else { acc-=v; }
            if(v>100){ acc+= (v/2); } else if(v<0){ acc-= (v*2); }
        }
    }
    return acc;
}

int main(){
    std::vector<std::vector<int>> m={{1,2,3},{100,101,102},{-3,-4,5}};
    std::cout<<heavy(m)<<"\n";
    return 0;
}
CPP

# ========== S6: Ниска четимост, малко коментари, непоследователно именуване ==========
cat > S6/README.md <<'MD'
S6 — ниска четимост: смесено именуване, почти без коментари, магически числа.
MD

cat > S6/src/main.cpp <<'CPP'
#include <iostream>
#include <vector>
int Do(std::vector<int> v){int r=0;for(size_t i=0;i<v.size();++i){if(v[i]>7)r+=v[i]*3;else r+=v[i]*2;}return r;}
int main(){std::vector<int> v={1,7,8,9};std::cout<<Do(v)<<"\n";return 0;}
CPP

# ========== S7: Доста добро решение, но с дребно дублиране/пропуск ==========
cat > S7/README.md <<'MD'
S7 — в добра форма, но с една повтаряща се проверка, която може да се извади в помощна функция.
MD

cat > S7/src/main.cpp <<'CPP'
#include <iostream>
#include <string>

bool validIdA(const std::string& s){
    if(s.size()<5) return false;
    if(!std::isalpha(static_cast<unsigned char>(s[0]))) return false;
    return true;
}
bool validIdB(const std::string& s){
    if(s.size()<5) return false; // дублиране на логика от validIdA
    if(!std::isalpha(static_cast<unsigned char>(s[0]))) return false;
    return true;
}

int main(){
    std::cout << std::boolalpha << validIdA("A1234") << " " << validIdB("B0000") << "\n";
    return 0;
}
CPP

echo "Sample student folders S1...S7 created."
