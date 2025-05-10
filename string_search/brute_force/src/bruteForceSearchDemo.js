// JavaScript
// 文字列の検索: ブルートフォース法 (Brute Force Search)

function search(text, pattern) {
  const n = text.length;
  const m = pattern.length;
  const positions = [];
  
  // パターンが空または検索対象より長い場合
  if (m === 0 || m > n) {
    return positions;
  }
  
  // テキスト内の各位置でパターンとの一致を確認
  for (let i = 0; i <= n - m; i++) {
    let j = 0;
    // パターンの各文字を確認
    while (j < m && text[i + j] === pattern[j]) {
      j++;
    }
    // パターンが完全に一致した場合
    if (j === m) {
      positions.push(i);
    }
  }
  
  return positions;
}

function main() {
  console.log("BruteForceSearch TEST -----> start");

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

  console.log("\nBruteForceSearch TEST <----- end");
}

// Node.jsでの実行環境を想定
if (require.main === module) {
  main();
}