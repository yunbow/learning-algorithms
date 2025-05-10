// Kotlin
// 文字列の検索: KMP (Knuth Morris Pratt)

fun computeLps(pattern: String): IntArray {
    val m = pattern.length
    val lps = IntArray(m) // LPSテーブルを初期化
    
    // 最初のインデックスのLPS値は常に0
    var length = 0
    var i = 1
    
    // LPSテーブルの残りの値を計算
    while (i < m) {
        if (pattern[i] == pattern[length]) {
            // 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
            length++
            lps[i] = length
            i++
        } else {
            // 文字が一致しない場合
            if (length != 0) {
                // 一致した部分文字列の前の位置のLPS値を使用
                length = lps[length - 1]
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

fun search(text: String, pattern: String): List<Int> {
    if (pattern.isEmpty() || text.isEmpty()) {
        return emptyList()
    }
    
    val n = text.length
    val m = pattern.length
    
    // パターン長がテキスト長より大きい場合、マッチングは不可能
    if (m > n) {
        return emptyList()
    }
    
    // LPSテーブルを計算
    val lps = computeLps(pattern)
    
    val result = mutableListOf<Int>() // マッチした位置のリスト
    var i = 0 // テキストのインデックス
    var j = 0 // パターンのインデックス
    
    while (i < n) {
        // 現在の文字が一致する場合
        if (pattern[j] == text[i]) {
            i++
            j++
        }
        
        // パターン全体がマッチした場合
        if (j == m) {
            // パターンの開始位置をresultに追加
            result.add(i - j)
            // 次の可能性のある一致を探すために、jをlps[j-1]に設定
            j = lps[j - 1]
        } 
        // 文字が一致しない場合
        else if (i < n && pattern[j] != text[i]) {
            // jが0でない場合、LPSテーブルを使って次の位置を決定
            if (j != 0) {
                j = lps[j - 1]
            } else {
                // jが0の場合、単純にテキストの次の文字に進む
                i++
            }
        }
    }
    
    return result
}

fun main() {
    println("Kmp TEST -----> start")

    println("\nsearch")
    val input1 = Pair("ABABCABCABABABD", "ABABD")
    println("  入力値: $input1")
    val output1 = search(input1.first, input1.second)
    println("  出力値: $output1")

    println("\nsearch")
    val input2 = Pair("AAAAAA", "AA")
    println("  入力値: $input2")
    val output2 = search(input2.first, input2.second)
    println("  出力値: $output2")

    println("\nsearch")
    val input3 = Pair("ABCDEFG", "XYZ")
    println("  入力値: $input3")
    val output3 = search(input3.first, input3.second)
    println("  出力値: $output3")

    println("\nsearch")
    val input4 = Pair("ABCABC", "ABC")
    println("  入力値: $input4")
    val output4 = search(input4.first, input4.second)
    println("  出力値: $output4")

    println("\nsearch")
    val input5 = Pair("ABC", "")
    println("  入力値: $input5")
    val output5 = search(input5.first, input5.second)
    println("  出力値: $output5")

    println("\nKmp TEST <----- end")
}