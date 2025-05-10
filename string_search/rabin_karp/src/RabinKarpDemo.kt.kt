fun search(text: String, pattern: String): List<Int> {
    val n = text.length
    val m = pattern.length
    
    // パターンが文字列より長い場合は検索できない
    if (m > n) {
        return emptyList()
    }
    
    // 空のパターンの場合は空リストを返す
    if (m == 0) {
        return emptyList()
    }
    
    // ハッシュ計算のための定数
    // 大きな素数を使用
    val q = 101
    val d = 256  // 文字セットのサイズ（ASCIIを想定）
    
    // パターンとテキスト最初のm文字のハッシュ値を計算
    var patternHash = 0
    var textHash = 0
    var h = 1
    
    // h = d^(m-1) mod q の計算
    for (i in 0 until m-1) {
        h = (h * d) % q
    }
    
    // パターンと初期ウィンドウのハッシュ値を計算
    for (i in 0 until m) {
        patternHash = (d * patternHash + pattern[i].code) % q
        textHash = (d * textHash + text[i].code) % q
    }
    
    val result = mutableListOf<Int>()
    
    // テキスト内を順に探索
    for (i in 0..n-m) {
        // ハッシュ値が一致した場合、文字ごとに比較して確認
        if (patternHash == textHash) {
            // 文字ごとのチェック
            var match = true
            for (j in 0 until m) {
                if (text[i+j] != pattern[j]) {
                    match = false
                    break
                }
            }
            
            if (match) {
                result.add(i)
            }
        }
        
        // 次のウィンドウのハッシュ値を計算
        if (i < n-m) {
            // 先頭の文字を削除し、新しい文字を追加
            textHash = (d * (textHash - text[i].code * h) + text[i+m].code) % q
            
            // 負の値になる場合は調整
            if (textHash < 0) {
                textHash += q
            }
        }
    }
    
    return result
}

fun main() {
    println("RabinKarp TEST -----> start")

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

    println("\nRabinKarp TEST <----- end")
}