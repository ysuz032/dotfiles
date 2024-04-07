# .gitconf.d


ここにgitconfigのプロジェクトごとの設定を入れる

~/.gitconfig.localから includeIf でディレクトリパスごとに読み込ませる

```
[includeIf "gitdir:{project-name}/"]
    path = ~/.gitconf.d/{project-name}.gitconfig
```