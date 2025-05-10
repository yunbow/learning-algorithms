package main

import (
	"fmt"
)

// computeLPS はパターンのLPS(Longest Prefix Suffix)テーブルを計算する
func computeLPS(pattern string) []int {
	m := len(pattern)
	lps := make([]int, m) // LPSテーブルを初期化

	// 最初のインデックスのLPS値は常に0
	length := 0
	i := 1

	// LPSテーブルの残りの値を計算
	for i < m {
		if pattern[i] == pattern[length] {
			// 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
			length++
			lps[i] = length
			i++
		} else {
			// 文字が一致しない場合
			if length != 0 {
				// 一致した部分文字列の前の位置のLPS値を使用
				length = lps[length-1]
				// iはインクリメントしない
			} else {
				// length = 0の場合、lps[i] = 0として次に進む
				lps[i] = 0
				i++
			}
		}
	}

	return lps
}

// search はテキスト内でパターンを検索し、マッチする位置のスライスを返す
func search(text, pattern string) []int {
	if pattern == "" || text == "" {
		return []int{}
	}

	n := len(text)
	m := len(pattern)

	// パターン長がテキスト長より大きい場合、マッチングは不可能
	if m > n {
		return []int{}
	}

	// LPSテーブルを計算
	lps := computeLPS(pattern)

	result := []int{} // マッチした位置のスライス
	i := 0            // テキストのインデックス
	j := 0            // パターンのインデックス

	for i < n {
		// 現在の文字が一致する場合
		if pattern[j] == text[i] {
			i++
			j++
		}

		// パターン全体がマッチした場合
		if j == m {
			// パターンの開始位置をresultに追加
			result = append(result, i-j)
			// 次の可能性のある一致を探すために、jをLPS[j-1]に設定
			j = lps[j-1]
		} else if i < n && pattern[j] != text[i] {
			// 文字が一致しない場合
			// jが0でない場合、LPSテーブルを使って次の位置を決定
			if j != 0 {
				j = lps[j-1]
			} else {
				// jが0の場合、単純にテキストの次の文字に進む
				i++
			}
		}
	}

	return result
}

func main() {
	fmt.Println("Kmp TEST -----> start")

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

	fmt.Println("\nKmp TEST <----- end")
}
