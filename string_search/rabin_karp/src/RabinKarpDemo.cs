using System;
using System.Collections.Generic;

class RabinKarp
{
    public static List<int> Search(string text, string pattern)
    {
        int n = text.Length;
        int m = pattern.Length;
        
        // パターンが文字列より長い場合は検索できない
        if (m > n)
        {
            return new List<int>();
        }
        
        // ハッシュ計算のための定数
        // 大きな素数を使用
        int q = 101;
        int d = 256;  // 文字セットのサイズ（ASCIIを想定）
        
        // パターンとテキスト最初のm文字のハッシュ値を計算
        int patternHash = 0;
        int textHash = 0;
        int h = 1;
        
        // h = d^(m-1) mod q の計算
        for (int i = 0; i < m - 1; i++)
        {
            h = (h * d) % q;
        }
        
        // パターンと初期ウィンドウのハッシュ値を計算
        for (int i = 0; i < m; i++)
        {
            patternHash = (d * patternHash + pattern[i]) % q;
            textHash = (d * textHash + text[i]) % q;
        }
        
        List<int> result = new List<int>();
        
        // テキスト内を順に探索
        for (int i = 0; i <= n - m; i++)
        {
            // ハッシュ値が一致した場合、文字ごとに比較して確認
            if (patternHash == textHash)
            {
                // 文字ごとのチェック
                bool match = true;
                for (int j = 0; j < m; j++)
                {
                    if (text[i + j] != pattern[j])
                    {
                        match = false;
                        break;
                    }
                }
                
                if (match)
                {
                    result.Add(i);
                }
            }
            
            // 次のウィンドウのハッシュ値を計算
            if (i < n - m)
            {
                // 先頭の文字を削除
                textHash = (d * (textHash - text[i] * h) + text[i + m]) % q;
                
                // 負の値になる場合は調整
                if (textHash < 0)
                {
                    textHash += q;
                }
            }
        }
        
        return result;
    }

    public static void Main()
    {
        Console.WriteLine("RabinKarp TEST -----> start");

        Console.WriteLine("\nSearch");
        var input1 = ("ABABCABCABABABD", "ABABD");
        Console.WriteLine($"  入力値: {input1}");
        var output1 = Search(input1.Item1, input1.Item2);
        Console.WriteLine($"  出力値: [{string.Join(", ", output1)}]");

        Console.WriteLine("\nSearch");
        var input2 = ("AAAAAA", "AA");
        Console.WriteLine($"  入力値: {input2}");
        var output2 = Search(input2.Item1, input2.Item2);
        Console.WriteLine($"  出力値: [{string.Join(", ", output2)}]");

        Console.WriteLine("\nSearch");
        var input3 = ("ABCDEFG", "XYZ");
        Console.WriteLine($"  入力値: {input3}");
        var output3 = Search(input3.Item1, input3.Item2);
        Console.WriteLine($"  出力値: [{string.Join(", ", output3)}]");

        Console.WriteLine("\nSearch");
        var input4 = ("ABCABC", "ABC");
        Console.WriteLine($"  入力値: {input4}");
        var output4 = Search(input4.Item1, input4.Item2);
        Console.WriteLine($"  出力値: [{string.Join(", ", output4)}]");

        Console.WriteLine("\nSearch");
        var input5 = ("ABC", "");
        Console.WriteLine($"  入力値: {input5}");
        var output5 = Search(input5.Item1, input5.Item2);
        Console.WriteLine($"  出力値: [{string.Join(", ", output5)}]");

        Console.WriteLine("\nRabinKarp TEST <----- end");
    }
}