// JavaScript
// 文字列の検索: ラビンカープ法 (Rabin Karp)

function search(text, pattern) {
    const n = text.length;
    const m = pattern.length;
    
    // パターンが文字列より長い場合は検索できない
    if (m > n) {
        return [];
    }
    
    // ハッシュ計算のための定数
    // 大きな素数を使用
    const q = 101;
    const d = 256;  // 文字セットのサイズ（ASCIIを想定）
    
    // パターンとテキスト最初のm文字のハッシュ値を計算
    let patternHash = 0;
    let textHash = 0;
    let h = 1;
    
    // h = d^(m-1) mod q の計算
    for (let i = 0; i < m - 1; i++) {
        h = (h * d) % q;
    }
    
    // パターンと初期ウィンドウのハッシュ値を計算
    for (let i = 0; i < m; i++) {
        patternHash = (d * patternHash + text.charCodeAt(i)) % q;
        textHash = (d * textHash + pattern.charCodeAt(i)) % q;
    }
    
    const result = [];
    
    // テキスト内を順に探索
    for (let i = 0; i <= n - m; i++) {
        // ハッシュ値が一致した場合、文字ごとに比較して確認
        if (patternHash === textHash) {
            // 文字ごとのチェック
            let match = true;
            for (let j = 0; j < m; j++) {
                if (text[i + j] !== pattern[j]) {
                    match = false;
                    break;
                }
            }
            
            if (match) {
                result.push(i);
            }
        }
        
        // 次のウィンドウのハッシュ値を計算
        if (i < n - m) {
            // 先頭の文字を削除
            textHash = (d * (textHash - text.charCodeAt(i) * h) + text.charCodeAt(i + m)) % q;
            
            // 負の値になる場合は調整
            if (textHash < 0) {
                textHash += q;
            }
        }
    }
    
    return result;
}

function main() {
    console.log("RabinKarp TEST -----> start");

    console.log("\nsearch");
    const input1 = ["ABABCABCABABABD", "ABABD"];
    console.log(`  入力値: ${input1}`);
    const output1 = search(input1[0], input1[1]);
    console.log(`  出力値: ${output1}`);

    console.log("\nsearch");
    const input2 = ["AAAAAA", "AA"];
    console.log(`  入力値: ${input2}`);
    const output2 = search(input2[0], input2[1]);
    console.log(`  出力値: ${output2}`);

    console.log("\nsearch");
    const input3 = ["ABCDEFG", "XYZ"];
    console.log(`  入力値: ${input3}`);
    const output3 = search(input3[0], input3[1]);
    console.log(`  出力値: ${output3}`);

    console.log("\nsearch");
    const input4 = ["ABCABC", "ABC"];
    console.log(`  入力値: ${input4}`);
    const output4 = search(input4[0], input4[1]);
    console.log(`  出力値: ${output4}`);

    console.log("\nsearch");
    const input5 = ["ABC", ""];
    console.log(`  入力値: ${input5}`);
    const output5 = search(input5[0], input5[1]);
    console.log(`  出力値: ${output5}`);

    console.log("\nRabinKarp TEST <----- end");
}

main();