// Rust
// 文字列の検索: ブルートフォース法 (Brute Force Search)

fn search(text: &str, pattern: &str) -> Vec<usize> {
    let n = text.len();
    let m = pattern.len();
    let mut positions = Vec::new();
    
    // パターンが空または検索対象より長い場合
    if m == 0 || m > n {
        return positions;
    }
    
    let text_bytes = text.as_bytes();
    let pattern_bytes = pattern.as_bytes();
    
    // テキスト内の各位置でパターンとの一致を確認
    for i in 0..=(n - m) {
        let mut j = 0;
        // パターンの各文字を確認
        while j < m && text_bytes[i + j] == pattern_bytes[j] {
            j += 1;
        }
        // パターンが完全に一致した場合
        if j == m {
            positions.push(i);
        }
    }
    
    positions
}

fn main() {
    println!("BruteForceSearch TEST -----> start");

    println!("\nsearch");
    let input = ("ABABCABCABABABD", "ABABD");
    println!("  入力値: {:?}", input);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("AAAAAA", "AA");
    println!("  入力値: {:?}", input);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABCDEFG", "XYZ");
    println!("  入力値: {:?}", input);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABCABC", "ABC");
    println!("  入力値: {:?}", input);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABC", "");
    println!("  入力値: {:?}", input);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nBruteForceSearch TEST <----- end");
}