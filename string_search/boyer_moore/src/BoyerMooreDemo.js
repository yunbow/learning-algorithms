// JavaScript
// 文字列の検索: ボイヤムーア法 (Boyer Moore Search)

function search(text, pattern) {
    if (!pattern || !text || pattern.length > text.length) {
        return [];
    }
    
    // 結果を格納する配列
    const occurrences = [];
    
    // 悪文字ルールのテーブル作成
    const badChar = badCharacterTable(pattern);
    
    // 良接尾辞ルールのテーブル作成
    const goodSuffix = goodSuffixTable(pattern);
    
    // 検索
    let i = pattern.length - 1;  // テキスト内の位置
    while (i < text.length) {
        let j = pattern.length - 1;  // パターン内の位置
        while (j >= 0 && text[i - pattern.length + 1 + j] === pattern[j]) {
            j--;
        }
        
        if (j < 0) {  // マッチした場合
            occurrences.push(i - pattern.length + 1);
            i += 1;
        } else {  // マッチしなかった場合
            // 悪文字ルールと良接尾辞ルールのシフト量の大きい方を採用
            const bcShift = Math.max(1, j - (badChar[text[i]] !== undefined ? badChar[text[i]] : -1));
            const gsShift = goodSuffix[j];
            i += Math.max(bcShift, gsShift);
        }
    }

    return occurrences;
}

function badCharacterTable(pattern) {
    // 悪文字ルールのテーブルを作成
    const badChar = {};
    for (let i = 0; i < pattern.length; i++) {
        badChar[pattern[i]] = i;
    }
    return badChar;
}

function goodSuffixTable(pattern) {
    // 良接尾辞ルールのテーブルを作成
    const n = pattern.length;
    // ボーダー配列の計算
    const border = new Array(n + 1).fill(0);
    border[n] = n;
    
    // 補助関数：Z配列の計算
    function zArray(pattern) {
        const n = pattern.length;
        const z = new Array(n).fill(0);
        let l = 0, r = 0;
        for (let i = 1; i < n; i++) {
            if (i <= r) {
                z[i] = Math.min(r - i + 1, z[i - l]);
            }
            while (i + z[i] < n && pattern[z[i]] === pattern[i + z[i]]) {
                z[i]++;
            }
            if (i + z[i] - 1 > r) {
                l = i;
                r = i + z[i] - 1;
            }
        }
        return z;
    }
    
    // パターンの逆順に対するZ配列
    const patternRev = pattern.split('').reverse().join('');
    const z = zArray(patternRev);
    
    for (let i = 0; i < n; i++) {
        const j = n - z[i];
        border[j] = i;
    }
    
    // 良接尾辞ルールのシフト量計算
    const shift = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        shift[i] = n;
    }
    
    for (let i = 0; i < n; i++) {
        const j = n - border[i];
        shift[n - j - 1] = j;
    }
    
    // ボーダーが存在しない場合の処理
    for (let i = 0; i < n - 1; i++) {
        const j = n - 1 - i;
        if (border[j] === j) {
            for (let k = 0; k < n - j; k++) {
                if (shift[k] === n) {
                    shift[k] = n - j;
                }
            }
        }
    }
    
    return shift;
}

function main() {
    console.log("BoyerMooreSearch TEST -----> start");

    console.log("\nsearch");
    const input1 = ["ABABCABCABABABD", "ABABD"];
    console.log(`  入力値: ${JSON.stringify(input1)}`);
    const output1 = search(...input1);
    console.log(`  出力値: ${JSON.stringify(output1)}`);

    console.log("\nsearch");
    const input2 = ["AAAAAA", "AA"];
    console.log(`  入力値: ${JSON.stringify(input2)}`);
    const output2 = search(...input2);
    console.log(`  出力値: ${JSON.stringify(output2)}`);

    console.log("\nsearch");
    const input3 = ["ABCDEFG", "XYZ"];
    console.log(`  入力値: ${JSON.stringify(input3)}`);
    const output3 = search(...input3);
    console.log(`  出力値: ${JSON.stringify(output3)}`);

    console.log("\nsearch");
    const input4 = ["ABCABC", "ABC"];
    console.log(`  入力値: ${JSON.stringify(input4)}`);
    const output4 = search(...input4);
    console.log(`  出力値: ${JSON.stringify(output4)}`);

    console.log("\nsearch");
    const input5 = ["ABC", ""];
    console.log(`  入力値: ${JSON.stringify(input5)}`);
    const output5 = search(...input5);
    console.log(`  出力値: ${JSON.stringify(output5)}`);

    console.log("\nBoyerMooreSearch TEST <----- end");
}

// プログラム実行
main();