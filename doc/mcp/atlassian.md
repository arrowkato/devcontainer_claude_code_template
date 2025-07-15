# Atlassian MCPサーバー


## 概要
JIRAとconfluenceにアクセスできます。
2025/07/15現在、β版とのことです。


## このリポジトリでの設定
```json
"atlassian": {
    "command": "npx",
    "args": [
        "-y",
        "mcp-remote",
        "https://mcp.atlassian.com/v1/sse"
    ]
}
```

Claude Codeを起動すると、ブラウザが開いて、認証する必要があります。あなたのアカウントでログインしてください。
ログインが成功すると、ブラウザを閉じて大丈夫です。

## 備考
ベータ版なので、仕方ないですが、ちょっと挙動がおぼつかない感じがします。
[JIRA REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v2/intro/#about) と [Confluence REST API](https://developer.atlassian.com/cloud/confluence/rest/v2/intro/#about) は公開されているので、公式の[Atlassian アカウントの API トークンを管理する](https://support.atlassian.com/ja/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/) のページに従ってTokenを作成して、環境変数等に設定しておき、よく使いそうなコマンドをいわゆる rules ファイル(※)に書いておくほうが現実的かもしれません。

(※) Claude Codeだと CLAUDE.md や .claude/ 配下のファイルです。


## 参考文献
- [Atlassian公式ページ](https://www.atlassian.com/platform/remote-mcp-server)
- [Using-the-Atlassian-Remote-MCP-Server-beta](https://community.atlassian.com/forums/Atlassian-Platform-articles/Using-the-Atlassian-Remote-MCP-Server-beta/ba-p/3005104)
- [Atlassian-Remote-MCP-Server-beta-now-available-for-desktop](https://community.atlassian.com/forums/Atlassian-Platform-articles/Atlassian-Remote-MCP-Server-beta-now-available-for-desktop/ba-p/3022084)
