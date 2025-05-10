# Ruby
# 素数判定: ソロベイシュトラッセン (Solovay Strassen)
require 'openssl'

def jacobi_symbol(a, n)
  # ヤコビ記号 (a/n) を計算する
  if a == 0
    return 0
  end
  if a == 1
    return 1
  end
  
  if a % 2 == 0
    return jacobi_symbol(a / 2, n) * ((-1) ** ((n*n - 1)/8))
  end
  
  if a >= n
    return jacobi_symbol(a % n, n)
  end
  
  if a % 2 == 1
    return jacobi_symbol(n, a) * ((-1) ** ((a-1)*(n-1)/4))
  end
end

def is_prime(target, k=10)
  # 基本的なケースの処理
  if target == 2 || target == 3
    return true
  end
  if target <= 1 || target % 2 == 0
    return false
  end
  
  # 指定した回数だけテストを繰り返す
  k.times do
    # 1からn-1の範囲でランダムな数aを選ぶ
    a = rand(2...target)
    
    # GCDが1でなければ、nは合成数
    if a.pow(target-1, target) != 1
      return false
    end
    
    # ヤコビ記号を計算
    j = jacobi_symbol(a, target)
    if j < 0
      j += target
    end
    
    # 疑似素数テスト
    if a.pow((target-1)/2, target) != j % target
      return false
    end
  end
  
  # すべてのテストをパスすれば、おそらく素数
  return true
end

def main
  puts "SolovayStrassen TEST -----> start"

  puts "\nis_prime"
  input_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997]
  input_list.each do |input|
    output = is_prime(input)
    puts "  #{input}: #{output}"
  end
  
  puts "\nSolovayStrassen TEST <----- end"
end

if __FILE__ == $0
  main
end