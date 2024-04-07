# chrome

## 概要
chromeの拡張機能をインストールする

## インストール
1. extensionsの各行のURLをChromeで開く
2. Chromeに追加をクリックして拡張機能をインストールする


## 拡張機能のリストを取得する方法
以下のコマンドを実行する

```
ls -l ${HOME}/Library/Application\ Support/Google/Chrome/Default/Extensions | awk '{print $9}' | sed 's/^/https:\/\/chrome.google.com\/webstore\/detail\//g' | sed -e '1,1d' > ~/dotfiles/chrome/extensions
```
