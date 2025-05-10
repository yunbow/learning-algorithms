// Go
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

package main

import (
	"fmt"
	"math"
	"math/big"
	"math/rand"
	"time"
)

// jacobiSymbol はヤコビ記号 (a/n) を計算する
func jacobiSymbol(a, n int) int {
	if a == 0 {
		return 0
	}
	if a == 1 {
		return 1
	}

	if a%2 == 0 {
		result := jacobiSymbol(a/2, n)
		if n%8 == 1 || n%8 == 7 {
			return result
		}
		return -result
	}

	if a >= n {
		return jacobiSymbol(a%n, n)
	}

	if a%2 == 1 {
		result := jacobiSymbol(n, a)
		if a%4 == 3 && n%4 == 3 {
			return -result
		}
		return result
	}

	return 0
}

// isPrime は Solovay-Strassen アルゴリズムを使って素数判定を行う
func isPrime(target int, k int) bool {
	// 基本的なケースの処理
	if target == 2 || target == 3 {
		return true
	}
	if target <= 1 || target%2 == 0 {
		return false
	}

	// 大きな数の計算のためにbig.Intを使用
	n := big.NewInt(int64(target))
	nMinus1 := big.NewInt(int64(target - 1))
	nMinus1Div2 := big.NewInt(0).Div(nMinus1, big.NewInt(2))

	// 指定した回数だけテストを繰り返す
	rnd := rand.New(rand.NewSource(time.Now().UnixNano()))
	for i := 0; i < k; i++ {
		// 1からn-1の範囲でランダムな数aを選ぶ
		aInt := big.NewInt(0)
		for {
			aInt.Rand(rnd, nMinus1)
			if aInt.Cmp(big.NewInt(1)) > 0 {
				break
			}
		}
		a := int(aInt.Int64())

		// フェルマーテスト: a^(n-1) mod n = 1
		modExp := big.NewInt(0).Exp(big.NewInt(int64(a)), nMinus1, n)
		if modExp.Cmp(big.NewInt(1)) != 0 {
			return false
		}

		// ヤコビ記号を計算
		j := jacobiSymbol(a, target)
		if j < 0 {
			j += target
		}

		// 疑似素数テスト
		modExpResult := big.NewInt(0).Exp(big.NewInt(int64(a)), nMinus1Div2, n)
		jBig := big.NewInt(int64(j % target))
		
		if modExpResult.Cmp(jBig) != 0 {
			return false
		}
	}

	// すべてのテストをパスすれば、おそらく素数
	return true
}

func main() {
	fmt.Println("SolovayStrassen TEST -----> start")

	fmt.Println("\nis_prime")
	inputList := []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997}
	for _, input := range inputList {
		output := isPrime(input, 10)
		fmt.Printf("  %d: %t\n", input, output)
	}

	fmt.Println("\nSolovayStrassen TEST <----- end")
}
