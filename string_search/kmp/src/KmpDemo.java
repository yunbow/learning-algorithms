import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class KmpDemo {
    
    private static int[] computeLps(String pattern) {
        int m = pattern.length();
        int[] lps = new int[m]; // LPSテーブルを初期化
        
        // 最初のインデックスのLPS値は常に0
        int length = 0;
        int i = 1;
        
        // LPSテーブルの残りの値を計算
        while (i < m) {
            if (pattern.charAt(i) == pattern.charAt(length)) {
                // 文字が一致する場合、lengthをインクリメントしてlps[i]に保存
                length++;
                lps[i] = length;
                i++;
            } else {
                // 文字が一致しない場合
                if (length != 0) {
                    // 一致した部分文字列の前の位置のLPS値を使用
                    length = lps[length - 1];
                    // iはインクリメントしない
                } else {
                    // length = 0の場合、lps[i] = 0として次に進む
                    lps[i] = 0;
                    i++;
                }
            }
        }
        
        return lps;
    }
    
    public static List<Integer> search(String text, String pattern) {
        if (pattern == null || pattern.isEmpty() || text == null || text.isEmpty()) {
            return new ArrayList<>();
        }
        
        int n = text.length();
        int m = pattern.length();
        
        // パターン長がテキスト長より大きい場合、マッチングは不可能
        if (m > n) {
            return new ArrayList<>();
        }
        
        // LPSテーブルを計算
        int[] lps = computeLps(pattern);
        
        List<Integer> result = new ArrayList<>(); // マッチした位置のリスト
        int i = 0; // テキストのインデックス
        int j = 0; // パターンのインデックス
        
        while (i < n) {
            // 現在の文字が一致する場合
            if (pattern.charAt(j) == text.charAt(i)) {
                i++;
                j++;
            }
            
            // パターン全体がマッチした場合
            if (j == m) {
                // パターンの開始位置をresultに追加
                result.add(i - j);
                // 次の可能性のある一致を探すために、jをlps[j-1]に設定
                j = lps[j - 1];
            }
            // 文字が一致しない場合
            else if (i < n && pattern.charAt(j) != text.charAt(i)) {
                // jが0でない場合、LPSテーブルを使って次の位置を決定
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    // jが0の場合、単純にテキストの次の文字に進む
                    i++;
                }
            }
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        System.out.println("Kmp TEST -----> start");
        
        System.out.println("\nsearch");
        String text = "ABABCABCABABABD";
        String pattern = "ABABD";
        System.out.println("  入力値: (" + text + ", " + pattern + ")");
        List<Integer> output = search(text, pattern);
        System.out.println("  出力値: " + output);
        
        System.out.println("\nsearch");
        text = "AAAAAA";
        pattern = "AA";
        System.out.println("  入力値: (" + text + ", " + pattern + ")");
        output = search(text, pattern);
        System.out.println("  出力値: " + output);
        
        System.out.println("\nsearch");
        text = "ABCDEFG";
        pattern = "XYZ";
        System.out.println("  入力値: (" + text + ", " + pattern + ")");
        output = search(text, pattern);
        System.out.println("  出力値: " + output);
        
        System.out.println("\nsearch");
        text = "ABCABC";
        pattern = "ABC";
        System.out.println("  入力値: (" + text + ", " + pattern + ")");
        output = search(text, pattern);
        System.out.println("  出力値: " + output);
        
        System.out.println("\nsearch");
        text = "ABC";
        pattern = "";
        System.out.println("  入力値: (" + text + ", " + pattern + ")");
        output = search(text, pattern);
        System.out.println("  出力値: " + output);
        
        System.out.println("\nKmp TEST <----- end");
    }
}