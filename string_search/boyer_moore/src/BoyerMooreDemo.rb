# Ruby
# 文字列の検索: ボイヤムーア法 (Boyer Moore Search)

def search(text, pattern)
  return [] if pattern.empty? || text.empty? || pattern.length > text.length
  
  # 結果を格納する配列
  occurrences = []
  
  # 悪文字ルールのテーブル作成
  bad_char = bad_character_table(pattern)
  
  # 良接尾辞ルールのテーブル作成
  good_suffix = good_suffix_table(pattern)
  
  # 検索
  i = pattern.length - 1  # テキスト内の位置
  while i < text.length
    j = pattern.length - 1  # パターン内の位置
    while j >= 0 && text[i - pattern.length + 1 + j] == pattern[j]
      j -= 1
    end
    
    if j < 0  # マッチした場合
      occurrences << (i - pattern.length + 1)
      i += 1
    else  # マッチしなかった場合
      # 悪文字ルールと良接尾辞ルールのシフト量の大きい方を採用
      bc_shift = [1, j - (bad_char[text[i]] || -1)].max
      gs_shift = good_suffix[j]
      i += [bc_shift, gs_shift].max
    end
  end

  occurrences
end

def bad_character_table(pattern)
  # 悪文字ルールのテーブルを作成
  bad_char = {}
  pattern.each_char.with_index do |char, i|
    bad_char[char] = i
  end
  bad_char
end

def good_suffix_table(pattern)
  # 良接尾辞ルールのテーブルを作成
  n = pattern.length
  # ボーダー配列の計算
  border = Array.new(n + 1, 0)
  border[n] = n
  
  # 補助関数：Z配列の計算
  def z_array(pattern)
    n = pattern.length
    z = Array.new(n, 0)
    l, r = 0, 0
    (1...n).each do |i|
      if i <= r
        z[i] = [r - i + 1, z[i - l]].min
      end
      while i + z[i] < n && pattern[z[i]] == pattern[i + z[i]]
        z[i] += 1
      end
      if i + z[i] - 1 > r
        l, r = i, i + z[i] - 1
      end
    end
    z
  end
  
  # パターンの逆順に対するZ配列
  pattern_rev = pattern.reverse
  z = z_array(pattern_rev)
  
  n.times do |i|
    j = n - z[i]
    border[j] = i
  end
  
  # 良接尾辞ルールのシフト量計算
  shift = Array.new(n, n)
  
  n.times do |i|
    j = n - border[i]
    shift[n - j - 1] = j
  end
  
  # ボーダーが存在しない場合の処理
  (n - 1).times do |i|
    j = n - 1 - i
    if border[j] == j
      (n - j).times do |k|
        if shift[k] == n
          shift[k] = n - j
        end
      end
    end
  end
  
  shift
end

def main
  puts "BoyerMooreSearch TEST -----> start"

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

  puts "\nBoyerMooreSearch TEST <----- end"
end

if __FILE__ == $0
  main
end