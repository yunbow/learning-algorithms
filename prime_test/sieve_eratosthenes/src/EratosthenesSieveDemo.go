// Go
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)

package main

import (
	"fmt"
	"math"
)

func isPrime(target int) bool {
	// 2未満の数は素数ではない
	if target < 2 {
		return false
	}
	// 2は唯一の偶数の素数
	if target == 2 {
		return true
	}
	// 2より大きい偶数は素数ではない
	if target%2 == 0 {
		return false
	}

	// エラトステネスのふるいを適用するためのbooleanスライスを作成
	// スライスのインデックスが数値を表す。isPrimeList[i] が true なら i は素数の可能性がある。
	// target までの判定を行うため、サイズは target + 1 とする。
	isPrimeList := make([]bool, target+1)
	for i := range isPrimeList {
		isPrimeList[i] = true
	}

	// 0と1は素数ではない
	isPrimeList[0] = false
	isPrimeList[1] = false

	// ふるいを実行
	// 判定の基となる素数 p は、target の平方根まで調べれば十分
	// target = p * q の場合、p または q の少なくとも一方は sqrt(target) 以下になるため
	limit := int(math.Sqrt(float64(target))) + 1

	for p := 2; p < limit; p++ {
		// もし p が素数の可能性があるなら (まだふるい落とされていなければ)
		if isPrimeList[p] {
			// p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
			// より小さい素数によって既にふるい落とされているため)
			// p*p から target までの p の倍数をすべて false に設定
			for multiple := p * p; multiple <= target; multiple += p {
				isPrimeList[multiple] = false
			}
		}
	}

	// ふるい落としが完了したら、判定したい数 target の状態を確認
	return isPrimeList[target]
}

func main() {
	fmt.Println("SieveOfEratosthenes TEST -----> start")

	fmt.Println("\nis_prime")
	inputList := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997}
	for _, input := range inputList {
		output := isPrime(input)
		fmt.Printf("  %d: %t\n", input, output)
	}

	fmt.Println("\nSieveOfEratosthenes TEST <----- end")
}