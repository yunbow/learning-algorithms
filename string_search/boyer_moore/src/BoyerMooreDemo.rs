fn search(text: &str, pattern: &str) -> Vec<usize> {
    let text_bytes = text.as_bytes();
    let pattern_bytes = pattern.as_bytes();
    
    if pattern.is_empty() || text.is_empty() || pattern.len() > text.len() {
        return Vec::new();
    }
    
    // 結果を格納するベクター
    let mut occurrences = Vec::new();
    
    // 悪文字ルールのテーブル作成
    let bad_char = bad_character_table(pattern_bytes);
    
    // 良接尾辞ルールのテーブル作成
    let good_suffix = good_suffix_table(pattern_bytes);
    
    // 検索
    let mut i = pattern_bytes.len() - 1;  // テキスト内の位置
    
    while i < text_bytes.len() {
        let mut j = pattern_bytes.len() - 1;  // パターン内の位置
        
        while j < pattern_bytes.len() && text_bytes[i - pattern_bytes.len() + 1 + j] == pattern_bytes[j] {
            if j == 0 {
                break;
            }
            j -= 1;
        }
        
        if j == 0 && text_bytes[i - pattern_bytes.len() + 1] == pattern_bytes[0] {  // マッチした場合
            occurrences.push(i - pattern_bytes.len() + 1);
            i += 1;
        } else {  // マッチしなかった場合
            // 悪文字ルールと良接尾辞ルールのシフト量の大きい方を採用
            let bc_shift = match bad_char.get(&text_bytes[i]) {
                Some(&idx) => {
                    std::cmp::max(1, j as isize - idx as isize) as usize
                },
                None => {
                    std::cmp::max(1, j + 1) as usize
                }
            };
            
            let gs_shift = good_suffix[j];
            i += std::cmp::max(bc_shift, gs_shift);
        }
    }
    
    occurrences
}

fn bad_character_table(pattern: &[u8]) -> std::collections::HashMap<u8, usize> {
    // 悪文字ルールのテーブルを作成
    let mut bad_char = std::collections::HashMap::new();
    
    for (i, &ch) in pattern.iter().enumerate() {
        bad_char.insert(ch, i);
    }
    
    bad_char
}

fn good_suffix_table(pattern: &[u8]) -> Vec<usize> {
    // 良接尾辞ルールのテーブルを作成
    let n = pattern.len();
    
    // ボーダー配列の計算
    let mut border = vec![0; n + 1];
    border[n] = n;
    
    // パターンの逆順に対するZ配列
    let mut pattern_rev = pattern.to_vec();
    pattern_rev.reverse();
    let z = z_array(&pattern_rev);
    
    for i in 0..n {
        let j = n - z[i];
        border[j] = i;
    }
    
    // 良接尾辞ルールのシフト量計算
    let mut shift = vec![0; n];
    for i in 0..n {
        shift[i] = n;
    }
    
    for i in 0..n {
        let j = n - border[i];
        shift[n - j - 1] = j;
    }
    
    // ボーダーが存在しない場合の処理
    for i in 0..n-1 {
        let j = n - 1 - i;
        if border[j] == j {
            for k in 0..n-j {
                if shift[k] == n {
                    shift[k] = n - j;
                }
            }
        }
    }
    
    shift
}

fn z_array(pattern: &[u8]) -> Vec<usize> {
    let n = pattern.len();
    let mut z = vec![0; n];
    
    let mut l = 0;
    let mut r = 0;
    
    for i in 1..n {
        if i <= r {
            z[i] = std::cmp::min(r - i + 1, z[i - l]);
        }
        
        while i + z[i] < n && pattern[z[i]] == pattern[i + z[i]] {
            z[i] += 1;
        }
        
        if i + z[i] - 1 > r {
            l = i;
            r = i + z[i] - 1;
        }
    }
    
    z
}

fn main() {
    println!("BoyerMooreSearch TEST -----> start");

    println!("\nsearch");
    let input = ("ABABCABCABABABD", "ABABD");
    println!("  入力値: ({}, {})", input.0, input.1);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("AAAAAA", "AA");
    println!("  入力値: ({}, {})", input.0, input.1);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABCDEFG", "XYZ");
    println!("  入力値: ({}, {})", input.0, input.1);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABCABC", "ABC");
    println!("  入力値: ({}, {})", input.0, input.1);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nsearch");
    let input = ("ABC", "");
    println!("  入力値: ({}, {})", input.0, input.1);
    let output = search(input.0, input.1);
    println!("  出力値: {:?}", output);

    println!("\nBoyerMooreSearch TEST <----- end");
}