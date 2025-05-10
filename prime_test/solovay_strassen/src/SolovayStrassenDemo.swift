// Swift
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

import Foundation

func jacobiSymbol(_ a: Int, _ n: Int) -> Int {
    // ヤコビ記号 (a/n) を計算する
    if a == 0 {
        return 0
    }
    if a == 1 {
        return 1
    }
    
    if a % 2 == 0 {
        return jacobiSymbol(a / 2, n) * Int(pow(-1.0, Double((n*n - 1)/8)))
    }
    
    if a >= n {
        return jacobiSymbol(a % n, n)
    }
    
    if a % 2 == 1 {
        return jacobiSymbol(n, a) * Int(pow(-1.0, Double((a-1)*(n-1)/4)))
    }
    
    return 0 // ここに到達することはないが、Swiftはすべてのパスで値を返す必要があるため
}

func isPrime(_ target: Int, k: Int = 10) -> Bool {
    // 基本的なケースの処理
    if target == 2 || target == 3 {
        return true
    }
    if target <= 1 || target % 2 == 0 {
        return false
    }
    
    // 指定した回数だけテストを繰り返す
    for _ in 0..<k {
        // 1からn-1の範囲でランダムな数aを選ぶ
        let a = Int.random(in: 2..<target)
        
        // GCDが1でなければ、nは合成数
        if modPow(a, target-1, target) != 1 {
            return false
        }
        
        // ヤコビ記号を計算
        var j = jacobiSymbol(a, target)
        if j < 0 {
            j += target
        }
            
        // 疑似素数テスト
        if modPow(a, (target-1)/2, target) != j % target {
            return false
        }
    }
    
    // すべてのテストをパスすれば、おそらく素数
    return true
}

// modular exponentiation (a^b mod m) を計算する関数
func modPow(_ base: Int, _ exponent: Int, _ modulus: Int) -> Int {
    // 基本的なケースの処理
    if modulus == 1 {
        return 0
    }
    
    var result = 1
    var b = base % modulus
    var e = exponent
    
    while e > 0 {
        if e % 2 == 1 {
            result = (result * b) % modulus
        }
        e >>= 1
        b = (b * b) % modulus
    }
    
    return result
}

func main() {
    print("SolovayStrassen TEST -----> start")

    print("\nisPrime")
    let inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997]
    for input in inputList {
        let output = isPrime(input)
        print("  \(input): \(output)")
    }
    
    print("\nSolovayStrassen TEST <----- end")
}

main()