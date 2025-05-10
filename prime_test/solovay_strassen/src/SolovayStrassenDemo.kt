// Kotlin
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

import kotlin.random.Random
import kotlin.math.pow

fun jacobiSymbol(a: Int, n: Int): Int {
    var a = a
    var n = n
    
    if (a == 0) return 0
    if (a == 1) return 1
    
    if (a % 2 == 0) {
        return jacobiSymbol(a / 2, n) * if ((n * n - 1) / 8 % 2 == 0) 1 else -1
    }
    
    if (a >= n) {
        return jacobiSymbol(a % n, n)
    }
    
    if (a % 2 == 1) {
        return jacobiSymbol(n, a) * if (((a - 1) * (n - 1)) / 4 % 2 == 0) 1 else -1
    }
    
    return 0 // この行は実行されないはずだが、Kotlinのコンパイラ要件を満たすために必要
}

fun isPrime(target: Int, k: Int = 10): Boolean {
    // 基本的なケースの処理
    if (target == 2 || target == 3) return true
    if (target <= 1 || target % 2 == 0) return false
    
    // 指定した回数だけテストを繰り返す
    repeat(k) {
        // 1からn-1の範囲でランダムな数aを選ぶ
        val a = Random.nextInt(2, target)
        
        // GCDが1でなければ、nは合成数
        if (modPow(a.toLong(), (target - 1).toLong(), target.toLong()).toInt() != 1) {
            return false
        }
        
        // ヤコビ記号を計算
        var j = jacobiSymbol(a, target)
        if (j < 0) {
            j += target
        }
            
        // 疑似素数テスト
        if (modPow(a.toLong(), ((target - 1) / 2).toLong(), target.toLong()).toInt() != j % target) {
            return false
        }
    }
    
    // すべてのテストをパスすれば、おそらく素数
    return true
}

// カスタムmodPow実装（Kotlinでは大きな指数のモジュラーべき乗にBigIntegerを使うことが一般的ですが、
// この実装では簡単にするため、Longの範囲内で計算します）
fun modPow(base: Long, exponent: Long, modulus: Long): Long {
    if (modulus == 1L) return 0
    
    var result = 1L
    var b = base % modulus
    var exp = exponent
    
    while (exp > 0) {
        if (exp % 2 == 1L) {
            result = (result * b) % modulus
        }
        exp = exp shr 1
        b = (b * b) % modulus
    }
    
    return result
}

fun main() {
    println("SolovayStrassen TEST -----> start")

    println("\nis_prime")
    val inputList = listOf(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997)
    for (input in inputList) {
        val output = isPrime(input)
        println("  $input: $output")
    }
    
    println("\nSolovayStrassen TEST <----- end")
}