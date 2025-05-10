// Rust
// 文字列の検索: KMP (Knuth Morris Pratt)

fn compute_lps(pattern: &str) -> Vec<usize> {
    let pattern_chars: Vec<char> = pattern.chars().collect();
    let m = pattern_chars.len();
    let mut lps = vec![0; m]; // LPSテーブルを初期化
    
    // 最初のインデックスのLPS値は常に0
    let mut length = 0;
    let mut i = 1;
    
    // LPSテーブルの残りの値を計算
    while i < m {
        if pattern_chars[i] == pattern_chars[length] {
            // 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
            length += 1;
            lps[i] = length;
            i += 1;
        } else {
            // 文字が一致しない場合
            if length != 0 {
                // 一致した部分文字列の前の位置のLPS値を使用
                length = lps[length - 1];
                // iはインクリメントしない
            } else {
                // length = 0の場合、lps[i] = 0として次に進む
                lps[i] = 0;
                i += 1;
            }
        }
    }
    
    lps
}

fn search(text: &str, pattern: &str) -> Vec<usize> {
    if pattern.is_empty() || text.is_empty() {
        return vec![];
    }
    
    let text_chars: Vec<char> = text.chars().collect();
    let pattern_chars: Vec<char> = pattern.chars().collect();
    
    let n = text_chars.len();
    let m = pattern_chars.len();
    
    // パターン長がテキスト長より大きい場合、マッチングは不可能
    if m > n {
        return vec![];
    }
    
    // LPSテーブルを計算
    let lps = compute_lps(pattern);
    
    let mut result = Vec::new(); // マッチした位置のリスト
    let mut i = 0; // テキストのインデックス
    let mut j = 0; // パターンのインデックス
    
    while i < n {
        // 現在の文字が一致する場合
        if pattern_chars[j] == text_chars[i] {
            i += 1;
            j += 1;
        }
        
        // パターン全体がマッチした場合
        if j == m {
            // パターンの開始位置をresultに追加
            result.push(i - j);
            // 次の可能性のある一致を探すために、jをLPS[j-1]に設定
            j = lps[j - 1];
        } else if i < n && pattern_chars[j] != text_chars[i] {
            // 文字が一致しない場合
            // jが0でない場合、LPSテーブルを使って次の位置を決定
            if j != 0 {
                j = lps[j - 1];
            } else {
                // jが0の場合、単純にテキストの次の文字に進む
                i += 1;
            }
        }
    }
    
    result
}

fn main() {
    println!("Kmp TEST -----> start");

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

    println!("\nKmp TEST <----- end");
}
