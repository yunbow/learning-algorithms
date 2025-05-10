# Ruby
# 文字列の検索: ラビンカープ法 (Rabin Karp)

def search(text, pattern)
  n = text.length
  m = pattern.length
  
  # パターンが文字列より長い場合は検索できない
  return [] if m > n
  return (0..n-m).to_a if m == 0
  
  # ハッシュ計算のための定数
  # 大きな素数を使用
  q = 101
  d = 256  # 文字セットのサイズ（ASCIIを想定）
  
  # パターンとテキスト最初のm文字のハッシュ値を計算
  pattern_hash = 0
  text_hash = 0
  h = 1
  
  # h = d^(m-1) mod q の計算
  (m-1).times do
    h = (h * d) % q
  end
  
  # パターンと初期ウィンドウのハッシュ値を計算
  m.times do |i|
    pattern_hash = (d * pattern_hash + pattern[i].ord) % q
    text_hash = (d * text_hash + text[i].ord) % q
  end
  
  result = []
  
  # テキスト内を順に探索
  (n - m + 1).times do |i|
    # ハッシュ値が一致した場合、文字ごとに比較して確認
    if pattern_hash == text_hash
      # 文字ごとのチェック
      match = true
      m.times do |j|
        if text[i+j] != pattern[j]
          match = false
          break
        end
      end
      
      result << i if match
    end
    
    # 次のウィンドウのハッシュ値を計算
    if i < n - m
      # 先頭の文字を削除
      text_hash = (d * (text_hash - text[i].ord * h) + text[i + m].ord) % q
      
      # 負の値になる場合は調整
      text_hash += q if text_hash < 0
    end
  end
  
  result
end

def main
  puts "RabinKarp TEST -----> start"

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

  puts "\nRabinKarp TEST <----- end"
end

if __FILE__ == $PROGRAM_NAME
  main
end