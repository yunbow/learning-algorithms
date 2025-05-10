// Swift
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)
import Foundation

func isPrime(_ target: Int) -> Bool {
    // 2未満の数は素数ではない
    if target < 2 {
        return false
    }
    // 2は唯一の偶数の素数
    if target == 2 {
        return true
    }
    // 2より大きい偶数は素数ではない
    if target % 2 == 0 {
        return false
    }
    
    // エラトステネスのふるいを適用するためのbooleanリストを作成
    // リストのインデックスが数値を表す。isPrimeList[i] が true なら i は素数の可能性がある。
    // target までの判定を行うため、サイズは target + 1 とする。
    var isPrimeList = [Bool](repeating: true, count: target + 1)
    
    // 0と1は素数ではない
    isPrimeList[0] = false
    isPrimeList[1] = false
    
    // ふるいを実行
    // 判定の基となる素数 p は、target の平方根まで調べれば十分
    // target = p * q の場合、p または q の少なくとも一方は sqrt(target) 以下になるため
    let limit = Int(sqrt(Double(target))) + 1
    
    for p in 2..<limit {
        // もし p が素数の可能性があるなら (まだふるい落とされていなければ)
        if isPrimeList[p] {
            // p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
            // より小さい素数によって既にふるい落とされているため)
            // p*p から target までの p の倍数をすべて false に設定
            var multiple = p * p
            while multiple <= target {
                isPrimeList[multiple] = false
                multiple += p
            }
        }
    }
    
    // ふるい落としが完了したら、判定したい数 target の状態を確認
    return isPrimeList[target]
}

func main() {
    print("SieveOfEratosthenes TEST -----> start")
    
    print("\nisPrime")
    let inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997]
    for input in inputList {
        let output = isPrime(input)
        print("  \(input): \(output)")
    }
    
    print("\nSieveOfEratosthenes TEST <----- end")
}

main()