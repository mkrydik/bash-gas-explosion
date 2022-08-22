# Bash Gas Explosion

Bash ガス爆発 (ダジャレ)


## 使い方 (？)

このプロジェクトは以下の環境で動作確認しました。

- Git For Windows SDK v1.0.8 : GNU bash v4.4.23(2)-release (x86_64-pc-msys)
- WSL2 Ubuntu v20.04.4 : GNU bash v5.0.17(1)-release (x86_64-pc-linux-gnu)
- macOS Monterey v12.4 : GNU bash v3.2.57(1)-release (x86_64-apple-darwin21)

次のように実行してください。

```bash
$ bash ./bash-gas-explosion.bash
```

![Screenshot](https://user-images.githubusercontent.com/57387361/185821841-2489721d-e540-44f8-a2fe-b4d42af5a8cd.png)

「バスガス爆発」が言えたら終了します。

第1引数で速度を調整できます (秒単位)。

```bash
# 高速実行
$ bash ./bash-gas-explosion.bash 0

# ゆっくり実行
$ bash ./bash-gas-explosion.bash 1.5
```


## コーディング関連コマンド

```bash
$ shellcheck ./bash-gas-explosion.bash
```
