#!/usr/bin/env bash
#################################################################################
# Bash Gas Explosion
# 
# Usage: $ bash ./bash-gas-explosion.bash [sleep]
# 
# Options:
#   sleep    Sleep seconds (default: 0.0001)
#################################################################################

set -o errexit    # `-e` : エラー時にスクリプトを終了する
set -o noclobber  # `-C` : リダイレクトでファイルを上書きできないようにする (上書きする際は `>|` と明記する)
set -o pipefail   # パイプのコマンドが失敗した場合にスクリプトを終了する

sleep=0.0001  # デフォルト値
if [[ "$1" =~ ^[0-9]+\.?[0-9]*$ ]]; then  # 第1引数が正数なら sleep コマンドで利用する
  sleep="$1"
fi

set -o nounset  # `-u` : 未定義の変数を禁止する (`$1` 未指定時のエラーを回避するためこの位置から有効にする)

# 正解となる文字列の配列
#readonly answer=('バ' 'ス' 'ガ' 'ス' 'バ' 'ク' 'ハ' 'ツ')  # 1文字ずつで完全一致は相当時間がかかるので止めておく
readonly answer=('バス' 'ガス' 'バク' 'ハツ')

# この中からランダムに1文字ずつ取得する・後半は噛んだ時の文字
#readonly chars=('バ' 'ス' 'ガ' 'ク' 'ハ' 'ツ'    'シュ' 'フ')  # 1文字ずつで完全一致させる場合
readonly chars=('バス' 'ガス' 'バク' 'ハツ'       'バシュ' 'バフ' 'ガク' 'ガフ')

# Bash シェル起動からの経過秒数が記録される変数をリセットする
SECONDS=0

# 抽出した文字列を入れていく一時配列
current_chars=()

# 無限ループやっていき
while true; do  #for i in {1..10}; do  # 有限ループでテストする時用
  random_char="${chars[ $(( RANDOM % ${#chars[*]} )) ]}"  # ランダムに一文字取得する
  current_chars+=("${random_char}")                       # 一時配列に格納する
  current_char_index="$(( ${#current_chars[*]} - 1 ))"    # 追加した要素の添字を拾う
  
  # 正解の配列から当該添字の文字を取得し比較する
  if [ "${answer[current_char_index]}" = "${random_char}" ]; then
    # 正しい文字が現れた場合 : 色を変えて出力する
    printf '\033[32m%s\033[0m' "${random_char}"  # `32m` 緑
    
    # 正解の配列と一時配列の長さが一致すれば完全一致とみなし終了する
    if [ "${answer[*]}" = "${current_chars[*]}" ]; then
      break
    fi
  else
    # 間違いの文字が現れた場合 : 「バシュ」だけ色を変えて出力する
    if [ "${random_char}" = 'バシュ' ]; then
      printf '\033[31m%s\033[0m' "${random_char}"  # `31m` 赤
    else
      printf '\033[37m%s\033[0m' "${random_char}"  # `37m` 白
    fi
    
    # 配列をリセットする
    unset current_chars  # 全要素を削除する
    current_chars=()     # インデックスを詰めるため配列を生成し直す
  fi
  
  if [ "${sleep}" != '0' ]; then  # 数値比較演算子は整数のみ許容するので文字列比較とする
    sleep "${sleep}"  # ゆっくりループする
  fi
done

printf '\n\n  \033[32mバスガス爆発！\033[0m\n'
printf '  かかった時間 : %s 秒\n' "${SECONDS}"
