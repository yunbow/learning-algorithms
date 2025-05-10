// Swift
// 文字列の検索: KMP (Knuth Morris Pratt)

func computeLPS(pattern: String) -> [Int] {
    let m = pattern.count
    var lps = Array(repeating: 0, count: m) // LPSテーブルを初期化
    let patternArray = Array(pattern)
    
    // 最初のインデックスのLPS値は常に0
    var length = 0
    var i = 1
    
    // LPSテーブルの残りの値を計算
    while i < m {
        if patternArray[i] == patternArray[length] {
            // 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
            length += 1
            lps[i] = length
            i += 1
        } else {
            // 文字が一致しない場合
            if length != 0 {
                // 一致した部分文字列の前の位置のLPS値を使用
                length = lps[length - 1]
                // iはインクリメントしない
            } else {
                // length = 0の場合、lps[i] = 0として次に進む
                lps[i] = 0
                i += 1
            }
        }
    }
    
    return lps
}

func search(text: String, pattern: String) -> [Int] {
    if pattern.isEmpty || text.isEmpty {
        return []
    }
    
    let n = text.count
    let m = pattern.count
    
    // パターン長がテキスト長より大きい場合、マッチングは不可能
    if m > n {
        return []
    }
    
    // LPSテーブルを計算
    let lps = computeLPS(pattern: pattern)
    
    var result = [Int]() // マッチした位置のリスト
    var i = 0 // テキストのインデックス
    var j = 0 // パターンのインデックス
    
    let textArray = Array(text)
    let patternArray = Array(pattern)
    
    while i < n {
        // 現在の文字が一致する場合
        if patternArray[j] == textArray[i] {
            i += 1
            j += 1
        }
        
        // パターン全体がマッチした場合
        if j == m {
            // パターンの開始位置をresultに追加
            result.append(i - j)
            // 次の可能性のある一致を探すために、jをLPS[j-1]に設定
            j = lps[j - 1]
        }
        // 文字が一致しない場合
        else if i < n && patternArray[j] != textArray[i] {
            // jが0でない場合、LPSテーブルを使って次の位置を決定
            if j != 0 {
                j = lps[j - 1]
            } else {
                // jが0の場合、単純にテキストの次の文字に進む
                i += 1
            }
        }
    }
    
    return result
}

func main() {
    print("Kmp TEST -----> start")
    
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
    
    print("\nKmp TEST <----- end")
}

main()