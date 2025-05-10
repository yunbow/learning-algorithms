// Kotlin
// 文字列の検索: ブルートフォース法 (Brute Force Search)

fun search(text: String, pattern: String): List<Int> {
    val n = text.length
    val m = pattern.length
    val positions = mutableListOf<Int>()
    
    // パターンが空または検索対象より長い場合
    if (m == 0 || m > n) {
        return positions
    }
    
    // テキスト内の各位置でパターンとの一致を確認
    for (i in 0..n - m) {
        var j = 0
        // パターンの各文字を確認
        while (j < m && text[i + j] == pattern[j]) {
            j++
        }
        // パターンが完全に一致した場合
        if (j == m) {
            positions.add(i)
        }
    }
    
    return positions
}

fun main() {
    println("BruteForceSearch TEST -----> start")

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

    println("\nBruteForceSearch TEST <----- end")
}