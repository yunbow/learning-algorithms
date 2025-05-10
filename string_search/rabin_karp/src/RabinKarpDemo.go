package main

import (
	"fmt"
)

// search はテキスト内でパターンを検索し、一致する位置のインデックスのスライスを返します
func search(text, pattern string) []int {
	n := len(text)
	m := len(pattern)
	
	// パターンが文字列より長い場合は検索できない
	if m > n {
		return []int{}
	}
	
	// ハッシュ計算のための定数
	// 大きな素数を使用
	q := 101
	d := 256 // 文字セットのサイズ（ASCIIを想定）
	
	// パターンとテキスト最初のm文字のハッシュ値を計算
	patternHash := 0
	textHash := 0
	h := 1
	
	// h = d^(m-1) mod q の計算
	for i := 0; i < m-1; i++ {
		h = (h * d) % q
	}
	
	// パターンと初期ウィンドウのハッシュ値を計算
	for i := 0; i < m; i++ {
		patternHash = (d*patternHash + int(text[i])) % q
		textHash = (d*textHash + int(text[i])) % q
	}
	
	result := []int{}
	
	// テキスト内を順に探索
	for i := 0; i <= n-m; i++ {
		// ハッシュ値が一致した場合、文字ごとに比較して確認
		if patternHash == textHash {
			// 文字ごとのチェック
			match := true
			for j := 0; j < m; j++ {
				if text[i+j] != pattern[j] {
					match = false
					break
				}
			}
			
			if match {
				result = append(result, i)
			}
		}
		
		// 次のウィンドウのハッシュ値を計算
		if i < n-m {
			// 先頭の文字を削除
			textHash = (d*(textHash-int(text[i])*h) + int(text[i+m])) % q
			
			// 負の値になる場合は調整
			if textHash < 0 {
				textHash += q
			}
		}
	}
	
	return result
}

func main() {
	fmt.Println("RabinKarp TEST -----> start")

	fmt.Println("\nsearch")
	input := []string{"ABABCABCABABABD", "ABABD"}
	fmt.Printf("  入力値: %v\n", input)
	output := search(input[0], input[1])
	fmt.Printf("  出力値: %v\n", output)

	fmt.Println("\nsearch")
	input = []string{"AAAAAA", "AA"}
	fmt.Printf("  入力値: %v\n", input)
	output = search(input[0], input[1])
	fmt.Printf("  出力値: %v\n", output)

	fmt.Println("\nsearch")
	input = []string{"ABCDEFG", "XYZ"}
	fmt.Printf("  入力値: %v\n", input)
	output = search(input[0], input[1])
	fmt.Printf("  出力値: %v\n", output)

	fmt.Println("\nsearch")
	input = []string{"ABCABC", "ABC"}
	fmt.Printf("  入力値: %v\n", input)
	output = search(input[0], input[1])
	fmt.Printf("  出力値: %v\n", output)

	fmt.Println("\nsearch")
	input = []string{"ABC", ""}
	fmt.Printf("  入力値: %v\n", input)
	output = search(input[0], input[1])
	fmt.Printf("  出力値: %v\n", output)

	fmt.Println("\nRabinKarp TEST <----- end")
}