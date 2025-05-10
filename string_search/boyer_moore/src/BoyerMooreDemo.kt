/**
 * 文字列の検索: ボイヤムーア法 (Boyer Moore Search)
 */

fun search(text: String, pattern: String): List<Int> {
    if (pattern.isEmpty() || text.isEmpty() || pattern.length > text.length) {
        return emptyList()
    }
    
    // 結果を格納するリスト
    val occurrences = mutableListOf<Int>()
    
    // 悪文字ルールのテーブル作成
    val badChar = badCharacterTable(pattern)
    
    // 良接尾辞ルールのテーブル作成
    val goodSuffix = goodSuffixTable(pattern)
    
    // 検索
    var i = pattern.length - 1  // テキスト内の位置
    while (i < text.length) {
        var j = pattern.length - 1  // パターン内の位置
        while (j >= 0 && text[i - pattern.length + 1 + j] == pattern[j]) {
            j--
        }
        
        if (j < 0) {  // マッチした場合
            occurrences.add(i - pattern.length + 1)
            i++
        } else {  // マッチしなかった場合
            // 悪文字ルールと良接尾辞ルールのシフト量の大きい方を採用
            val bcShift = maxOf(1, j - badChar.getOrDefault(text[i], -1))
            val gsShift = goodSuffix[j]
            i += maxOf(bcShift, gsShift)
        }
    }

    return occurrences
}

fun badCharacterTable(pattern: String): Map<Char, Int> {
    // 悪文字ルールのテーブルを作成
    val badChar = mutableMapOf<Char, Int>()
    for (i in pattern.indices) {
        badChar[pattern[i]] = i
    }
    return badChar
}

fun goodSuffixTable(pattern: String): IntArray {
    // 良接尾辞ルールのテーブルを作成
    val n = pattern.length
    // ボーダー配列の計算
    val border = IntArray(n + 1)
    border[n] = n
    
    // パターンの逆順に対するZ配列
    val patternRev = pattern.reversed()
    val z = zArray(patternRev)
    
    for (i in 0 until n) {
        val j = n - z[i]
        border[j] = i
    }
    
    // 良接尾辞ルールのシフト量計算
    val shift = IntArray(n) { n }
    
    for (i in 0 until n) {
        val j = n - border[i]
        shift[n - j - 1] = j
    }
    
    // ボーダーが存在しない場合の処理
    for (i in 0 until n - 1) {
        val j = n - 1 - i
        if (border[j] == j) {
            for (k in 0 until n - j) {
                if (shift[k] == n) {
                    shift[k] = n - j
                }
            }
        }
    }
    
    return shift
}

// Z配列の計算
fun zArray(pattern: String): IntArray {
    val n = pattern.length
    val z = IntArray(n)
    var l = 0
    var r = 0
    for (i in 1 until n) {
        if (i <= r) {
            z[i] = minOf(r - i + 1, z[i - l])
        }
        while (i + z[i] < n && pattern[z[i]] == pattern[i + z[i]]) {
            z[i]++
        }
        if (i + z[i] - 1 > r) {
            l = i
            r = i + z[i] - 1
        }
    }
    return z
}

fun main() {
    println("BoyerMooreSearch TEST -----> start")

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

    println("\nBoyerMooreSearch TEST <----- end")
}
