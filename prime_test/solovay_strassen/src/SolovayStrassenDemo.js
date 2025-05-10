// JavaScript
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

function jacobiSymbol(a, n) {
    // ヤコビ記号 (a/n) を計算する
    if (a === 0) {
        return 0;
    }
    if (a === 1) {
        return 1;
    }
    
    if (a % 2 === 0) {
        return jacobiSymbol(Math.floor(a / 2), n) * Math.pow(-1, (n * n - 1) / 8);
    }
    
    if (a >= n) {
        return jacobiSymbol(a % n, n);
    }
    
    if (a % 2 === 1) {
        return jacobiSymbol(n, a) * Math.pow(-1, (a - 1) * (n - 1) / 4);
    }
}

function modPow(base, exponent, modulus) {
    if (modulus === 1) return 0;
    
    let result = 1;
    base = base % modulus;
    
    while (exponent > 0) {
        if (exponent % 2 === 1) {
            result = (result * base) % modulus;
        }
        exponent = Math.floor(exponent / 2);
        base = (base * base) % modulus;
    }
    
    return result;
}

function isPrime(target, k = 10) {
    // 基本的なケースの処理
    if (target === 2 || target === 3) {
        return true;
    }
    if (target <= 1 || target % 2 === 0) {
        return false;
    }
    
    // 指定した回数だけテストを繰り返す
    for (let i = 0; i < k; i++) {
        // 1からn-1の範囲でランダムな数aを選ぶ
        const a = Math.floor(Math.random() * (target - 3)) + 2;
        
        // GCDが1でなければ、nは合成数
        if (modPow(a, target - 1, target) !== 1) {
            return false;
        }
        
        // ヤコビ記号を計算
        let j = jacobiSymbol(a, target);
        if (j < 0) {
            j += target;
        }
        
        // 疑似素数テスト
        if (modPow(a, Math.floor((target - 1) / 2), target) !== j % target) {
            return false;
        }
    }
    
    // すべてのテストをパスすれば、おそらく素数
    return true;
}

function main() {
    console.log("SolovayStrassen TEST -----> start");

    console.log("\nisPrime");
    const inputList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997];
    for (const input of inputList) {
        const output = isPrime(input);
        console.log(`  ${input}: ${output}`);
    }
    
    console.log("\nSolovayStrassen TEST <----- end");
}

// メイン関数の実行
main();