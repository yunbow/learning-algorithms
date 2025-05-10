// JavaScript
// 文字列の検索: KMP (Knuth Morris Pratt)

function computeLps(pattern) {
  const m = pattern.length;
  const lps = new Array(m).fill(0); // LPSテーブルを初期化
  
  // 最初のインデックスのLPS値は常に0
  let length = 0;
  let i = 1;
  
  // LPSテーブルの残りの値を計算
  while (i < m) {
    if (pattern[i] === pattern[length]) {
      // 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
      length++;
      lps[i] = length;
      i++;
    } else {
      // 文字が一致しない場合
      if (length !== 0) {
        // 一致した部分文字列の前の位置のLPS値を使用
        length = lps[length - 1];
        // iはインクリメントしない
      } else {
        // lenght = 0の場合、lps[i] = 0として次に進む
        lps[i] = 0;
        i++;
      }
    }
  }
  
  return lps;
}

function search(text, pattern) {
  if (!pattern || !text) {
    return [];
  }
  
  const n = text.length;
  const m = pattern.length;
  
  // パターン長がテキスト長より大きい場合、マッチングは不可能
  if (m > n) {
    return [];
  }
  
  // LPSテーブルを計算
  const lps = computeLps(pattern);
  
  const result = []; // マッチした位置のリスト
  let i = 0; // テキストのインデックス
  let j = 0; // パターンのインデックス
  
  while (i < n) {
    // 現在の文字が一致する場合
    if (pattern[j] === text[i]) {
      i++;
      j++;
    }
    
    // パターン全体がマッチした場合
    if (j === m) {
      // パターンの開始位置をresultに追加
      result.push(i - j);
      // 次の可能性のある一致を探すために、jをLPS[j-1]に設定
      j = lps[j - 1];
    } 
    // 文字が一致しない場合
    else if (i < n && pattern[j] !== text[i]) {
      // jが0でない場合、LPSテーブルを使って次の位置を決定
      if (j !== 0) {
        j = lps[j - 1];
      } else {
        // jが0の場合、単純にテキストの次の文字に進む
        i++;
      }
    }
  }
  
  return result;
}

function main() {
  console.log("Kmp TEST -----> start");

  console.log("\nsearch");
  let input = ["ABABCABCABABABD", "ABABD"];
  console.log(`  入力値: ${JSON.stringify(input)}`);
  let output = search(...input);
  console.log(`  出力値: ${JSON.stringify(output)}`);

  console.log("\nsearch");
  input = ["AAAAAA", "AA"];
  console.log(`  入力値: ${JSON.stringify(input)}`);
  output = search(...input);
  console.log(`  出力値: ${JSON.stringify(output)}`);

  console.log("\nsearch");
  input = ["ABCDEFG", "XYZ"];
  console.log(`  入力値: ${JSON.stringify(input)}`);
  output = search(...input);
  console.log(`  出力値: ${JSON.stringify(output)}`);

  console.log("\nsearch");
  input = ["ABCABC", "ABC"];
  console.log(`  入力値: ${JSON.stringify(input)}`);
  output = search(...input);
  console.log(`  出力値: ${JSON.stringify(output)}`);

  console.log("\nsearch");
  input = ["ABC", ""];
  console.log(`  入力値: ${JSON.stringify(input)}`);
  output = search(...input);
  console.log(`  出力値: ${JSON.stringify(output)}`);

  console.log("\nKmp TEST <----- end");
}

// Node.jsでの実行用
main();