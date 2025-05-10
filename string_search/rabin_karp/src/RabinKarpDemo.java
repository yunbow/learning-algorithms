import java.util.ArrayList;
import java.util.List;

public class RabinKarpDemo {
    
    public static List<Integer> search(String text, String pattern) {
        int n = text.length();
        int m = pattern.length();
        
        // パターンが文字列より長い場合は検索できない
        if (m > n) {
            return new ArrayList<>();
        }
        
        // ハッシュ計算のための定数
        // 大きな素数を使用
        int q = 101;
        int d = 256; // 文字セットのサイズ（ASCIIを想定）
        
        // パターンとテキスト最初のm文字のハッシュ値を計算
        int patternHash = 0;
        int textHash = 0;
        int h = 1;
        
        // h = d^(m-1) mod q の計算
        for (int i = 0; i < m - 1; i++) {
            h = (h * d) % q;
        }
        
        // パターンと初期ウィンドウのハッシュ値を計算
        for (int i = 0; i < m; i++) {
            patternHash = (d * patternHash + pattern.charAt(i)) % q;
            textHash = (d * textHash + text.charAt(i)) % q;
        }
        
        List<Integer> result = new ArrayList<>();
        
        // テキスト内を順に探索
        for (int i = 0; i <= n - m; i++) {
            // ハッシュ値が一致した場合、文字ごとに比較して確認
            if (patternHash == textHash) {
                // 文字ごとのチェック
                boolean match = true;
                for (int j = 0; j < m; j++) {
                    if (text.charAt(i + j) != pattern.charAt(j)) {
                        match = false;
                        break;
                    }
                }
                
                if (match) {
                    result.add(i);
                }
            }
            
            // 次のウィンドウのハッシュ値を計算
            if (i < n - m) {
                // 先頭の文字を削除
                textHash = (d * (textHash - text.charAt(i) * h) + text.charAt(i + m)) % q;
                
                // 負の値になる場合は調整
                if (textHash < 0) {
                    textHash += q;
                }
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println("RabinKarp TEST -----> start");
        
        System.out.println("\nsearch");
        String[] input1 = {"ABABCABCABABABD", "ABABD"};
        System.out.println("  入力値: [" + input1[0] + ", " + input1[1] + "]");
        List<Integer> output1 = search(input1[0], input1[1]);
        System.out.println("  出力値: " + output1);
        
        System.out.println("\nsearch");
        String[] input2 = {"AAAAAA", "AA"};
        System.out.println("  入力値: [" + input2[0] + ", " + input2[1] + "]");
        List<Integer> output2 = search(input2[0], input2[1]);
        System.out.println("  出力値: " + output2);
        
        System.out.println("\nsearch");
        String[] input3 = {"ABCDEFG", "XYZ"};
        System.out.println("  入力値: [" + input3[0] + ", " + input3[1] + "]");
        List<Integer> output3 = search(input3[0], input3[1]);
        System.out.println("  出力値: " + output3);
        
        System.out.println("\nsearch");
        String[] input4 = {"ABCABC", "ABC"};
        System.out.println("  入力値: [" + input4[0] + ", " + input4[1] + "]");
        List<Integer> output4 = search(input4[0], input4[1]);
        System.out.println("  出力値: " + output4);
        
        System.out.println("\nsearch");
        String[] input5 = {"ABC", ""};
        System.out.println("  入力値: [" + input5[0] + ", " + input5[1] + "]");
        List<Integer> output5 = search(input5[0], input5[1]);
        System.out.println("  出力値: " + output5);
        
        System.out.println("\nRabinKarp TEST <----- end");
    }
}