// Swift
// 文字列の検索: ラビンカープ法 (Rabin Karp)

func search(text: String, pattern: String) -> [Int] {
    let n = text.count
    let m = pattern.count
    
    // パターンが文字列より長い場合は検索できない
    if m > n {
        return []
    }
    
    // 空のパターンの場合
    if m == 0 {
        return []
    }
    
    // ハッシュ計算のための定数
    // 大きな素数を使用
    let q = 101
    let d = 256 // 文字セットのサイズ（ASCIIを想定）
    
    // パターンとテキスト最初のm文字のハッシュ値を計算
    var patternHash = 0
    var textHash = 0
    var h = 1
    
    // Swiftでは文字列を直接インデックスでアクセスできないため、配列に変換
    let textArray = Array(text)
    let patternArray = Array(pattern)
    
    // h = d^(m-1) mod q の計算
    for _ in 0..<(m-1) {
        h = (h * d) % q
    }
    
    // パターンと初期ウィンドウのハッシュ値を計算
    for i in 0..<m {
        patternHash = (d * patternHash + Int(patternArray[i].asciiValue ?? 0)) % q
        textHash = (d * textHash + Int(textArray[i].asciiValue ?? 0)) % q
    }
    
    var result: [Int] = []
    
    // テキスト内を順に探索
    for i in 0...(n - m) {
        // ハッシュ値が一致した場合、文字ごとに比較して確認
        if patternHash == textHash {
            // 文字ごとのチェック
            var match = true
            for j in 0..<m {
                if textArray[i+j] != patternArray[j] {
                    match = false
                    break
                }
            }
            
            if match {
                result.append(i)
            }
        }
        
        // 次のウィンドウのハッシュ値を計算
        if i < n - m {
            // 先頭の文字を削除
            textHash = (d * (textHash - Int(textArray[i].asciiValue ?? 0) * h) + Int(textArray[i + m].asciiValue ?? 0)) % q
            
            // 負の値になる場合は調整
            if textHash < 0 {
                textHash += q
            }
        }
    }
    
    return result
}

func main() {
    print("RabinKarp TEST -----> start")
    
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
    
    print("\nRabinKarp TEST <----- end")
}

main()