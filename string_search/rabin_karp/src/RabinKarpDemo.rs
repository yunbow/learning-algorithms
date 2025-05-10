fn search(text: &str, pattern: &str) -> Vec<usize> {
    let text_bytes = text.as_bytes();
    let pattern_bytes = pattern.as_bytes();
    
    let n = text_bytes.len();
    let m = pattern_bytes.len();
    
    let mut result = Vec::new();
    
    // パターンが文字列より長い場合は検索できない
    if m > n || m == 0 {
        return result;
    }
    
    // ハッシュ計算のための定数
    // 大きな素数を使用
    let q: u64 = 101;
    let d: u64 = 256;  // 文字セットのサイズ（ASCIIを想定）
    
    // パターンとテキスト最初のm文字のハッシュ値を計算
    let mut pattern_hash: u64 = 0;
    let mut text_hash: u64 = 0;
    let mut h: u64 = 1;
    
    // h = d^(m-1) mod q の計算
    for _ in 0..m-1 {
        h = (h * d) % q;
    }
    
    // パターンと初期ウィンドウのハッシュ値を計算
    for i in 0..m {
        pattern_hash = (d * pattern_hash + pattern_bytes[i] as u64) % q;
        text_hash = (d * text_hash + text_bytes[i] as u64) % q;
    }
    
    // テキスト内を順に探索
    for i in 0..=n-m {
        // ハッシュ値が一致した場合、文字ごとに比較して確認
        if pattern_hash == text_hash {
            // 文字ごとのチェック
            let mut match_found = true;
            for j in 0..m {
                if text_bytes[i+j] != pattern_bytes[j] {
                    match_found = false;
                    break;
                }
            }
            
            if match_found {
                result.push(i);
            }
        }
        
        // 次のウィンドウのハッシュ値を計算
        if i < n-m {
            // 先頭の文字を削除し、新しい文字を追加
            text_hash = (d * (text_hash + q - (text_bytes[i] as u64 * h) % q) + text_bytes[i+m] as u64) % q;
        }
    }
    
    result
}

fn main() {
    println!("RabinKarp TEST -----> start");

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

    println!("\nRabinKarp TEST <----- end");
}