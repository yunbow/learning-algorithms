// Swift
// 文字列の検索: ボイヤムーア法 (Boyer Moore Search)

func search(text: String, pattern: String) -> [Int] {
    if pattern.isEmpty || text.isEmpty || pattern.count > text.count {
        return []
    }
    
    // 結果を格納する配列
    var occurrences: [Int] = []
    
    // 悪文字ルールのテーブル作成
    let badChar = badCharacterTable(pattern: pattern)
    
    // 良接尾辞ルールのテーブル作成
    let goodSuffix = goodSuffixTable(pattern: pattern)
    
    // 検索
    var i = pattern.count - 1  // テキスト内の位置
    let textArray = Array(text)
    let patternArray = Array(pattern)
    
    while i < textArray.count {
        var j = patternArray.count - 1  // パターン内の位置
        while j >= 0 && textArray[i - patternArray.count + 1 + j] == patternArray[j] {
            j -= 1
        }
        
        if j < 0 {  // マッチした場合
            occurrences.append(i - patternArray.count + 1)
            i += 1
        } else {  // マッチしなかった場合
            // 悪文字ルールと良接尾辞ルールのシフト量の大きい方を採用
            let bcShift = max(1, j - badChar[textArray[i], default: -1])
            let gsShift = goodSuffix[j]
            i += max(bcShift, gsShift)
        }
    }
    
    return occurrences
}

func badCharacterTable(pattern: String) -> [Character: Int] {
    // 悪文字ルールのテーブルを作成
    var badChar: [Character: Int] = [:]
    let patternArray = Array(pattern)
    
    for i in 0..<patternArray.count {
        badChar[patternArray[i]] = i
    }
    
    return badChar
}

func goodSuffixTable(pattern: String) -> [Int] {
    // 良接尾辞ルールのテーブルを作成
    let n = pattern.count
    let patternArray = Array(pattern)
    
    // ボーダー配列の計算
    var border = Array(repeating: 0, count: n + 1)
    border[n] = n
    
    // 補助関数：Z配列の計算
    func zArray(pattern: [Character]) -> [Int] {
        let n = pattern.count
        var z = Array(repeating: 0, count: n)
        var l = 0
        var r = 0
        
        for i in 1..<n {
            if i <= r {
                z[i] = min(r - i + 1, z[i - l])
            }
            while i + z[i] < n && pattern[z[i]] == pattern[i + z[i]] {
                z[i] += 1
            }
            if i + z[i] - 1 > r {
                l = i
                r = i + z[i] - 1
            }
        }
        
        return z
    }
    
    // パターンの逆順に対するZ配列
    let patternRev = patternArray.reversed()
    let z = zArray(pattern: Array(patternRev))
    
    for i in 0..<n {
        let j = n - z[i]
        border[j] = i
    }
    
    // 良接尾辞ルールのシフト量計算
    var shift = Array(repeating: n, count: n)
    
    for i in 0..<n {
        let j = n - border[i]
        shift[n - j - 1] = j
    }
    
    // ボーダーが存在しない場合の処理
    for i in 0..<(n - 1) {
        let j = n - 1 - i
        if border[j] == j {
            for k in 0..<(n - j) {
                if shift[k] == n {
                    shift[k] = n - j
                }
            }
        }
    }
    
    return shift
}

func main() {
    print("BoyerMooreSearch TEST -----> start")
    
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
    
    print("\nBoyerMooreSearch TEST <----- end")
}

main()