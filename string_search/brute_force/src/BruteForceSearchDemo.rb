# Ruby
# 文字列の検索: ブルートフォース法 (Brute Force Search)

def search(text, pattern)
  n = text.length
  m = pattern.length
  positions = []
  
  # パターンが空または検索対象より長い場合
  if m == 0 || m > n
    return positions
  end
  
  # テキスト内の各位置でパターンとの一致を確認
  (0..n - m).each do |i|
    j = 0
    # パターンの各文字を確認
    while j < m && text[i + j] == pattern[j]
      j += 1
    end
    # パターンが完全に一致した場合
    if j == m
      positions << i
    end
  end
  
  return positions
end

def main
  puts "BruteForceSearch TEST -----> start"

  puts "\nsearch"
  input = ["ABABCABCABABABD", "ABABD"]
  puts "  入力値: #{input}"
  output = search(*input)
  puts "  出力値: #{output}"

  puts "\nsearch"
  input = ["AAAAAA", "AA"]
  puts "  入力値: #{input}"
  output = search(*input)
  puts "  出力値: #{output}"

  puts "\nsearch"
  input = ["ABCDEFG", "XYZ"]
  puts "  入力値: #{input}"
  output = search(*input)
  puts "  出力値: #{output}"

  puts "\nsearch"
  input = ["ABCABC", "ABC"]
  puts "  入力値: #{input}"
  output = search(*input)
  puts "  出力値: #{output}"

  puts "\nsearch"
  input = ["ABC", ""]
  puts "  入力値: #{input}"
  output = search(*input)
  puts "  出力値: #{output}"

  puts "\nBruteForceSearch TEST <----- end"
end

if __FILE__ == $0
  main
end