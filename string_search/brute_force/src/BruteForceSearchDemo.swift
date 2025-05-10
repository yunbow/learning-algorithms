// Swift
// 文字列の検索: ブルートフォース法 (Brute Force Search)

func search(text: String, pattern: String) -> [Int] {
    let n = text.count
    let m = pattern.count
    var positions: [Int] = []
    
    // パターンが空または検索対象より長い場合
    if m == 0 || m > n {
        return positions
    }
    
    // テキスト内の各位置でパターンとの一致を確認
    for i in 0...(n - m) {
        var j = 0
        // パターンの各文字を確認
        while j < m && text[text.index(text.startIndex, offsetBy: i + j)] == pattern[pattern.index(pattern.startIndex, offsetBy: j)] {
            j += 1
        }
        // パターンが完全に一致した場合
        if j == m {
            positions.append(i)
        }
    }
    
    return positions
}

func main() {
    print("BruteForceSearch TEST -----> start")

    print("\nsearch")
    let input1 = ("ABABCABCABABABD", "ABABD")
    print("  入力値: \(input1)")
    let output1 = search(text: input1.0, pattern: input1.1)
    print("  出力値: \(output1)")

    print("\nsearch")
    let input2 = ("AAAAAA", "AA")
    print("  入力値: \(input2)")
    let output2 = search(text: input2.0, pattern: input2.1)
    print("  出力値: \(output2)")

    print("\nsearch")
    let input3 = ("ABCDEFG", "XYZ")
    print("  入力値: \(input3)")
    let output3 = search(text: input3.0, pattern: input3.1)
    print("  出力値: \(output3)")

    print("\nsearch")
    let input4 = ("ABCABC", "ABC")
    print("  入力値: \(input4)")
    let output4 = search(text: input4.0, pattern: input4.1)
    print("  出力値: \(output4)")

    print("\nsearch")
    let input5 = ("ABC", "")
    print("  入力値: \(input5)")
    let output5 = search(text: input5.0, pattern: input5.1)
    print("  出力値: \(output5)")

    print("\nBruteForceSearch TEST <----- end")
}

main()