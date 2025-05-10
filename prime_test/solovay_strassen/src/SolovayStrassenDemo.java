// Java
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

import java.util.Random;

public class SolovayStrassenDemo {
    
    private static int jacobiSymbol(int a, int n) {
        // ヤコビ記号 (a/n) を計算する
        if (a == 0) {
            return 0;
        }
        if (a == 1) {
            return 1;
        }
        
        if (a % 2 == 0) {
            return jacobiSymbol(a / 2, n) * (int)Math.pow(-1, (n*n - 1)/8);
        }
        
        if (a >= n) {
            return jacobiSymbol(a % n, n);
        }
        
        if (a % 2 == 1) {
            return jacobiSymbol(n, a) * (int)Math.pow(-1, (a-1)*(n-1)/4);
        }
        
        return 0; // 到達しないはずですが、Javaはreturn文を必要とします
    }
    
    private static boolean isPrime(int target, int k) {
        // 基本的なケースの処理
        if (target == 2 || target == 3) {
            return true;
        }
        if (target <= 1 || target % 2 == 0) {
            return false;
        }
        
        Random random = new Random();
        
        // 指定した回数だけテストを繰り返す
        for (int i = 0; i < k; i++) {
            // 1からn-1の範囲でランダムな数aを選ぶ
            int a = random.nextInt(target - 2) + 2; // 2 から target-1 の範囲
            
            // GCDが1でなければ、nは合成数
            if (modPow(a, target-1, target) != 1) {
                return false;
            }
            
            // ヤコビ記号を計算
            int j = jacobiSymbol(a, target);
            if (j < 0) {
                j += target;
            }
            
            // 疑似素数テスト
            if (modPow(a, (target-1)/2, target) != j % target) {
                return false;
            }
        }
        
        // すべてのテストをパスすれば、おそらく素数
        return true;
    }
    
    // カスタムmodPow関数（Javaの組み込みModPowはBigIntegerでのみ使用可能）
    private static int modPow(int base, int exponent, int modulus) {
        if (modulus == 1) return 0;
        
        int result = 1;
        base = base % modulus;
        
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = (result * base) % modulus;
            }
            exponent = exponent >> 1;
            base = (base * base) % modulus;
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println("SolovayStrassen TEST -----> start");
        
        System.out.println("\nis_prime");
        int[] inputList = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997};
        for (int input : inputList) {
            boolean output = isPrime(input, 10);
            System.out.println("  " + input + ": " + output);
        }
        
        System.out.println("\nSolovayStrassen TEST <----- end");
    }
}