// C++
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)

#include <iostream>
#include <vector>
#include <cmath>

bool is_prime(int target) {
    // 2未満の数は素数ではない
    if (target < 2) {
        return false;
    }
    // 2は唯一の偶数の素数
    if (target == 2) {
        return true;
    }
    // 2より大きい偶数は素数ではない
    if (target % 2 == 0) {
        return false;
    }

    // エラトステネスのふるいを適用するためのbooleanベクトルを作成
    // ベクトルのインデックスが数値を表す。is_prime_vec[i] が true なら i は素数の可能性がある。
    // target までの判定を行うため、サイズは target + 1 とする。
    std::vector<bool> is_prime_vec(target + 1, true);

    // 0と1は素数ではない
    is_prime_vec[0] = is_prime_vec[1] = false;

    // ふるいを実行
    // 判定の基となる素数 p は、target の平方根まで調べれば十分
    // target = p * q の場合、p または q の少なくとも一方は sqrt(target) 以下になるため
    int limit = static_cast<int>(std::sqrt(target)) + 1;

    for (int p = 2; p < limit; ++p) {
        // もし p が素数の可能性があるなら (まだふるい落とされていなければ)
        if (is_prime_vec[p]) {
            // p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
            // より小さい素数によって既にふるい落とされているため)
            // p*p から target までの p の倍数をすべて false に設定
            for (int multiple = p * p; multiple <= target; multiple += p) {
                is_prime_vec[multiple] = false;
            }
        }
    }

    // ふるい落としが完了したら、判定したい数 target の状態を確認
    return is_prime_vec[target];
}

int main() {
    std::cout << "SieveOfEratosthenes TEST -----> start" << std::endl;

    std::cout << "\nis_prime" << std::endl;
    std::vector<int> input_list = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997};
    for (int input : input_list) {
        bool output = is_prime(input);
        std::cout << "  " << input << ": " << std::boolalpha << output << std::endl;
    }
    
    std::cout << "\nSieveOfEratosthenes TEST <----- end" << std::endl;
    
    return 0;
}