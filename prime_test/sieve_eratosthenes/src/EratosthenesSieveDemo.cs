// C#
// 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)

using System;
using System.Collections.Generic;

class Program
{
    static bool IsPrime(int target)
    {
        // 2未満の数は素数ではない
        if (target < 2)
        {
            return false;
        }
        // 2は唯一の偶数の素数
        if (target == 2)
        {
            return true;
        }
        // 2より大きい偶数は素数ではない
        if (target % 2 == 0)
        {
            return false;
        }

        // エラトステネスのふるいを適用するためのbooleanリストを作成
        // リストのインデックスが数値を表す。is_prime[i] が True なら i は素数の可能性がある。
        // target までの判定を行うため、サイズは target + 1 とする。
        bool[] isPrimeList = new bool[target + 1];
        
        // すべての値をデフォルトでtrueに設定
        for (int i = 0; i < isPrimeList.Length; i++)
        {
            isPrimeList[i] = true;
        }

        // 0と1は素数ではない
        isPrimeList[0] = isPrimeList[1] = false;

        // ふるいを実行
        // 判定の基となる素数 p は、target の平方根まで調べれば十分
        // target = p * q の場合、p または q の少なくとも一方は sqrt(target) 以下になるため
        int limit = (int)Math.Sqrt(target) + 1;

        for (int p = 2; p < limit; p++)
        {
            // もし p が素数の可能性があるなら (まだふるい落とされていなければ)
            if (isPrimeList[p])
            {
                // p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
                // より小さい素数によって既にふるい落とされているため)
                // p*p から target までの p の倍数をすべて False に設定
                for (int multiple = p * p; multiple <= target; multiple += p)
                {
                    isPrimeList[multiple] = false;
                }
            }
        }

        // ふるい落としが完了したら、判定したい数 target の状態を確認
        return isPrimeList[target];
    }

    static void Main()
    {
        Console.WriteLine("SieveOfEratosthenes TEST -----> start");

        Console.WriteLine("\nIsPrime");
        int[] inputList = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997 };
        foreach (int input in inputList)
        {
            bool output = IsPrime(input);
            Console.WriteLine($"  {input}: {output}");
        }

        Console.WriteLine("\nSieveOfEratosthenes TEST <----- end");
    }
}