// JavaScript
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)

import * as math from 'mathjs';

function isPrime(target) {
  // 2未満の数は素数ではない
  if (target < 2) {
    return false;
  }
  // 2は唯一の偶数の素数
  if (target === 2) {
    return true;
  }
  // 2より大きい偶数は素数ではない
  if (target % 2 === 0) {
    return false;
  }

  // エラトステネスのふるいを適用するためのbooleanリストを作成
  // リストのインデックスが数値を表す。isPrimeList[i] が true なら i は素数の可能性がある。
  // num までの判定を行うため、サイズは num + 1 とする。
  const isPrimeList = Array(target + 1).fill(true);

  // 0と1は素数ではない
  isPrimeList[0] = isPrimeList[1] = false;

  // ふるいを実行
  // 判定の基となる素数 p は、num の平方根まで調べれば十分
  // num = p * q の場合、p または q の少なくとも一方は sqrt(num) 以下になるため
  const limit = Math.floor(Math.sqrt(target)) + 1;

  for (let p = 2; p < limit; p++) {
    // もし p が素数の可能性があるなら (まだふるい落とされていなければ)
    if (isPrimeList[p]) {
      // p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
      // より小さい素数によって既にふるい落とされているため)
      // p*p から num までの p の倍数をすべて false に設定
      for (let multiple = p * p; multiple <= target; multiple += p) {
        isPrimeList[multiple] = false;
      }
    }
  }

  // ふるい落としが完了したら、判定したい数 num の状態を確認
  return isPrimeList[target];
}

function main() {
  console.log("SieveOfEratosthenes TEST -----> start");

  console.log("\nisPrime");
  const inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997];
  for (const input of inputList) {
    const output = isPrime(input);
    console.log(`  ${input}: ${output}`);
  }

  console.log("\nSieveOfEratosthenes TEST <----- end");
}

// Node.jsで実行する場合
main();