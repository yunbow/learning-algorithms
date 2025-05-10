// C#
// 素数判定: ソロベイシュトラッセン (Solovay Strassen)

using System;
using System.Collections.Generic;
using System.Numerics;

namespace SolovayStrassenDemo
{
    class Program
    {
        static int JacobiSymbol(BigInteger a, BigInteger n)
        {
            // ヤコビ記号 (a/n) を計算する
            if (a == 0)
                return 0;
            if (a == 1)
                return 1;

            if (a % 2 == 0)
                return JacobiSymbol(a / 2, n) * (int)BigInteger.Pow(-1, (int)((n * n - 1) / 8));

            if (a >= n)
                return JacobiSymbol(a % n, n);

            if (a % 2 == 1)
                return JacobiSymbol(n, a) * (int)BigInteger.Pow(-1, (int)((a - 1) * (n - 1) / 4));

            return 0; // ここには到達しないはず
        }

        static bool IsPrime(int target, int k = 10)
        {
            // 基本的なケースの処理
            if (target == 2 || target == 3)
                return true;
            if (target <= 1 || target % 2 == 0)
                return false;

            Random random = new Random();

            // 指定した回数だけテストを繰り返す
            for (int i = 0; i < k; i++)
            {
                // 1からn-1の範囲でランダムな数aを選ぶ
                int a = random.Next(2, target - 1);

                // GCDが1でなければ、nは合成数
                if (BigInteger.ModPow(a, target - 1, target) != 1)
                    return false;

                // ヤコビ記号を計算
                int j = JacobiSymbol(a, target);
                if (j < 0)
                    j += target;

                // 疑似素数テスト
                if (BigInteger.ModPow(a, (target - 1) / 2, target) != j % target)
                    return false;
            }

            // すべてのテストをパスすれば、おそらく素数
            return true;
        }

        static void Main(string[] args)
        {
            Console.WriteLine("SolovayStrassen TEST -----> start");

            Console.WriteLine("\nIsPrime");
            int[] inputList = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997 };
            foreach (int input in inputList)
            {
                bool output = IsPrime(input);
                Console.WriteLine($"  {input}: {output}");
            }

            Console.WriteLine("\nSolovayStrassen TEST <----- end");
        }
    }
}