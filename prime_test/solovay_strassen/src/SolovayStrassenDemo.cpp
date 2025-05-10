// C++
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <random>

// ヤコビ記号 (a/n) を計算する
int jacobi_symbol(int a, int n) {
    if (a == 0) {
        return 0;
    }
    if (a == 1) {
        return 1;
    }
    
    if (a % 2 == 0) {
        return jacobi_symbol(a / 2, n) * ((n * n - 1) / 8 % 2 == 0 ? 1 : -1);
    }
    
    if (a >= n) {
        return jacobi_symbol(a % n, n);
    }
    
    if (a % 2 == 1) {
        return jacobi_symbol(n, a) * ((a - 1) * (n - 1) / 4 % 2 == 0 ? 1 : -1);
    }
    
    return 0;  // ここには到達しないはずだが、コンパイラの警告を避けるため
}

// 冪剰余を計算する関数
int pow_mod(int base, int exponent, int mod) {
    long long result = 1;
    long long x = base % mod;
    
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = (result * x) % mod;
        }
        exponent = exponent >> 1;
        x = (x * x) % mod;
    }
    
    return static_cast<int>(result);
}

bool is_prime(int target, int k = 10) {
    // 基本的なケースの処理
    if (target == 2 || target == 3) {
        return true;
    }
    if (target <= 1 || target % 2 == 0) {
        return false;
    }
    
    // 乱数生成器の初期化
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> dis(2, target - 1);
    
    // 指定した回数だけテストを繰り返す
    for (int i = 0; i < k; i++) {
        // 1からn-1の範囲でランダムな数aを選ぶ
        int a = dis(gen);
        
        // GCDが1でなければ、nは合成数
        if (pow_mod(a, target - 1, target) != 1) {
            return false;
        }
        
        // ヤコビ記号を計算
        int j = jacobi_symbol(a, target);
        if (j < 0) {
            j += target;
        }
        
        // 疑似素数テスト
        if (pow_mod(a, (target - 1) / 2, target) != j % target) {
            return false;
        }
    }
    
    // すべてのテストをパスすれば、おそらく素数
    return true;
}

int main() {
    std::cout << "SolovayStrassen TEST -----> start" << std::endl;

    std::cout << "\nis_prime" << std::endl;
    std::vector<int> input_list = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997};
    for (int input : input_list) {
        bool output = is_prime(input);
        std::cout << "  " << input << ": " << (output ? "true" : "false") << std::endl;
    }
    
    std::cout << "\nSolovayStrassen TEST <----- end" << std::endl;
    
    return 0;
}