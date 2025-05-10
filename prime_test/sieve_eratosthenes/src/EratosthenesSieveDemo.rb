# Ruby
# 素数判定: エラトステネスのふるい (Sieve of Eratosthenes)
require 'prime'
require 'math'

def is_prime(target)
  # 2未満の数は素数ではない
  return false if target < 2
  # 2は唯一の偶数の素数
  return true if target == 2
  # 2より大きい偶数は素数ではない
  return false if target % 2 == 0

  # エラトステネスのふるいを適用するためのbooleanの配列を作成
  # 配列のインデックスが数値を表す。is_prime[i] が true なら i は素数の可能性がある。
  # num までの判定を行うため、サイズは num + 1 とする。
  is_prime_list = Array.new(target + 1, true)

  # 0と1は素数ではない
  is_prime_list[0] = is_prime_list[1] = false

  # ふるいを実行
  # 判定の基となる素数 p は、num の平方根まで調べれば十分
  # num = p * q の場合、p または q の少なくとも一方は sqrt(num) 以下になるため
  limit = Math.sqrt(target).to_i + 1

  (2...limit).each do |p|
    # もし p が素数の可能性があるなら (まだふるい落とされていなければ)
    if is_prime_list[p]
      # p の倍数をふるい落とす (p*p から開始するのは、それより小さい倍数は
      # より小さい素数によって既にふるい落とされているため)
      # p*p から num までの p の倍数をすべて false に設定
      (p * p).step(target, p) do |multiple|
        is_prime_list[multiple] = false
      end
    end
  end

  # ふるい落としが完了したら、判定したい数 num の状態を確認
  return is_prime_list[target]
end

def main
  puts "SieveOfEratosthenes TEST -----> start"

  puts "\nis_prime"
  input_list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 97, 100, 101, 997]
  input_list.each do |input|
    output = is_prime(input)
    puts "  #{input}: #{output}"
  end
  
  puts "\nSieveOfEratosthenes TEST <----- end"
end

if __FILE__ == $0
  main
end