// Ruby
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

use rand::Rng;

fn jacobi_symbol(mut a: i64, mut n: i64) -> i64 {
    if a == 0 {
        return 0;
    }
    if a == 1 {
        return 1;
    }
    
    let mut result = 1;
    
    if a < 0 {
        a = -a;
        if n % 4 == 3 {
            result = -result;
        }
    }
    
    while a != 0 {
        while a % 2 == 0 {
            a /= 2;
            if n % 8 == 3 || n % 8 == 5 {
                result = -result;
            }
        }
        
        std::mem::swap(&mut a, &mut n);
        
        if a % 4 == 3 && n % 4 == 3 {
            result = -result;
        }
        
        a %= n;
    }
    
    if n == 1 {
        return result;
    } else {
        return 0;
    }
}

fn mod_pow(mut base: i64, mut exp: i64, modulus: i64) -> i64 {
    if modulus == 1 {
        return 0;
    }
    
    let mut result = 1;
    base = base % modulus;
    
    while exp > 0 {
        if exp % 2 == 1 {
            result = (result * base) % modulus;
        }
        exp >>= 1;
        base = (base * base) % modulus;
    }
    
    result
}

fn is_prime(target: i64, k: u32) -> bool {
    // 基本的なケースの処理
    if target == 2 || target == 3 {
        return true;
    }
    if target <= 1 || target % 2 == 0 {
        return false;
    }
    
    let mut rng = rand::thread_rng();
    
    // 指定した回数だけテストを繰り返す
    for _ in 0..k {
        // 1からn-1の範囲でランダムな数aを選ぶ
        let a = rng.gen_range(2..target);
        
        // フェルマーテスト
        if mod_pow(a, target - 1, target) != 1 {
            return false;
        }
        
        // ヤコビ記号を計算
        let mut j = jacobi_symbol(a, target);
        if j < 0 {
            j += target;
        }
        
        // 疑似素数テスト
        if mod_pow(a, (target - 1) / 2, target) != j % target {
            return false;
        }
    }
    
    // すべてのテストをパスすれば、おそらく素数
    true
}

fn main() {
    println!("SolovayStrassen TEST -----> start");
    
    println!("\nis_prime");
    let input_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997];
    for &input in &input_list {
        let output = is_prime(input, 10);
        println!("  {}: {}", input, output);
    }
    
    println!("\nSolovayStrassen TEST <----- end");
}
