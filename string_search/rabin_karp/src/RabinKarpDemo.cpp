#include <iostream>
#include <vector>
#include <string>

// 文字列の検索: ラビンカープ法 (Rabin Karp)
std::vector<int> search(const std::string& text, const std::string& pattern) {
    int n = text.length();
    int m = pattern.length();
    
    std::vector<int> result;
    
    // パターンが文字列より長い場合は検索できない
    if (m > n) {
        return result;
    }
    
    // 空のパターンの場合は処理しない
    if (m == 0) {
        return result;
    }
    
    // ハッシュ計算のための定数
    // 大きな素数を使用
    int q = 101;
    int d = 256;  // 文字セットのサイズ（ASCIIを想定）
    
    // パターンとテキスト最初のm文字のハッシュ値を計算
    int pattern_hash = 0;
    int text_hash = 0;
    int h = 1;
    
    // h = d^(m-1) mod q の計算
    for (int i = 0; i < m-1; i++) {
        h = (h * d) % q;
    }
    
    // パターンと初期ウィンドウのハッシュ値を計算
    for (int i = 0; i < m; i++) {
        pattern_hash = (d * pattern_hash + pattern[i]) % q;
        text_hash = (d * text_hash + text[i]) % q;
    }
    
    // テキスト内を順に探索
    for (int i = 0; i <= n - m; i++) {
        // ハッシュ値が一致した場合、文字ごとに比較して確認
        if (pattern_hash == text_hash) {
            // 文字ごとのチェック
            bool match = true;
            for (int j = 0; j < m; j++) {
                if (text[i+j] != pattern[j]) {
                    match = false;
                    break;
                }
            }
            
            if (match) {
                result.push_back(i);
            }
        }
        
        // 次のウィンドウのハッシュ値を計算
        if (i < n - m) {
            // 先頭の文字を削除し、新しい文字を追加
            text_hash = (d * (text_hash - text[i] * h) + text[i + m]) % q;
            
            // 負の値になる場合は調整
            if (text_hash < 0) {
                text_hash += q;
            }
        }
    }
    
    return result;
}

void printResult(const std::vector<int>& result) {
    std::cout << "  出力値: [";
    for (size_t i = 0; i < result.size(); ++i) {
        std::cout << result[i];
        if (i < result.size() - 1) {
            std::cout << ", ";
        }
    }
    std::cout << "]" << std::endl;
}

int main() {
    std::cout << "RabinKarp TEST -----> start" << std::endl;
    
    std::cout << "\nsearch" << std::endl;
    std::string text = "ABABCABCABABABD";
    std::string pattern = "ABABD";
    std::cout << "  入力値: (" << text << ", " << pattern << ")" << std::endl;
    auto output = search(text, pattern);
    printResult(output);
    
    std::cout << "\nsearch" << std::endl;
    text = "AAAAAA";
    pattern = "AA";
    std::cout << "  入力値: (" << text << ", " << pattern << ")" << std::endl;
    output = search(text, pattern);
    printResult(output);
    
    std::cout << "\nsearch" << std::endl;
    text = "ABCDEFG";
    pattern = "XYZ";
    std::cout << "  入力値: (" << text << ", " << pattern << ")" << std::endl;
    output = search(text, pattern);
    printResult(output);
    
    std::cout << "\nsearch" << std::endl;
    text = "ABCABC";
    pattern = "ABC";
    std::cout << "  入力値: (" << text << ", " << pattern << ")" << std::endl;
    output = search(text, pattern);
    printResult(output);
    
    std::cout << "\nsearch" << std::endl;
    text = "ABC";
    pattern = "";
    std::cout << "  入力値: (" << text << ", " << pattern << ")" << std::endl;
    output = search(text, pattern);
    printResult(output);
    
    std::cout << "\nRabinKarp TEST <----- end" << std::endl;
    
    return 0;
}