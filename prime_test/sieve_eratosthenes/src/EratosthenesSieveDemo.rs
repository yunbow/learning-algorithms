// Rust
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)

fn is_prime(target: u64) -> bool {
    // 2未満の数は素数ではない
    if target < 2 {
        return false;
    }
    // 2は唯一の偶数の素数
    if target == 2 {
        return true;
    }
    // 2より大きい偶数は素数ではない
    if target % 2 == 0 {
        return false;
    }

    // エラトステネスのふるいを適用するためのbooleanベクターを作成
    // ベクターのインデックスが数値を表す。is_prime[i] が true なら i は素数の可能性がある。
    // target までの判定を行うため、サイズは target + 1 とする。
    let mut is_prime_list = vec![true; (target + 1) as usize];

    // 0と1は素数ではない
    is_prime_list[0] = false;
    is_prime_list[1] = false;

    // ふるいを実行
    // 判定の基となる素数 p は、target の平方根まで調べれば十分
    // target = p * q の場合、p または q の少なくとも一方は sqrt(target) 以下になるため
    let limit = (f64::sqrt(target as f64) as u64) + 1;

    for p in 2..limit {
        // もし p が素数の可能性があるなら (まだふるい落とされていなければ)
        if is_prime_list[p as usize] {
            // p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
            // より小さい素数によって既にふるい落とされているため)
            // p*p から target までの p の倍数をすべて false に設定
            let mut multiple = p * p;
            while multiple <= target {
                is_prime_list[multiple as usize] = false;
                multiple += p;
            }
        }
    }

    // ふるい落としが完了したら、判定したい数 target の状態を確認
    is_prime_list[target as usize]
}

fn main() {
    println!("SieveOfEratosthenes TEST -----> start");

    println!("\nis_prime");
    let input_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997];
    for &input in &input_list {
        let output = is_prime(input);
        println!("  {}: {}", input, output);
    }
    
    println!("\nSieveOfEratosthenes TEST <----- end");
}
