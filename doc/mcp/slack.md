# Slack MCPサーバー

## 概要

Slack MCPサーバーは、Slackワークスペースの参照及びメッセージの投稿をすることができます。

## このリポジトリでの設定

Slack MCPサーバーは`.mcp.json`で設定され、SlackのBot TokenとTeam IDが必要です。

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-slack"
      ],
      "env": {
        "SLACK_BOT_TOKEN": "${SLACK_BOT_TOKEN}", // TOKENなので隠すべき
        "SLACK_TEAM_ID": "${SLACK_TEAM_ID}", // 社内で使うGitHub等のprivateな「リポジトリ」ならば、ここは直接書いてもいいと思います
        "SLACK_CHANNEL_IDS": "${SLACK_CHANNEL_IDS}" // 社内で使うGitHub等のprivateな「リポジトリ」ならば、ここは直接書いてもいいと思います
      }
    }
  }
}
```

`.mcp.json` ファイル上の環境変数は、コンテナ上の環境変数です。
compose.yaml を参照してください。

もととなる値は、 `.env` ファイルで設定しています。
```ini
SLACK_BOT_TOKEN="xoxb-your-bot-token-here"
SLACK_TEAM_ID="T1234567890"
SLACK_CHANNEL_IDS="C1234567890,C0987654321" # 複数指定する場合は、カンマ区切り
```

あなたが使っているSlackのチャンネルにブラウザでアクセスすると`https://app.slack.com/client/<TEAM_ID>/<CHANNEL_ID>` という構成になっているはずです。


## Slack App設定

公式の[Setuup](https://github.com/modelcontextprotocol/servers-archived/tree/main/src/slack) を参照してください。

参照したいチャンネルの全てに、作成したSlack Appをインストールしてください。


## セキュリティ考慮事項

- Bot Tokenは機密情報です。`.env`ファイルに保存し、Gitにコミットしないでください
- 必要最小限のスコープのみを付与してください
- `SLACK_CHANNEL_IDS`を設定してアクセス可能なチャンネルを制限することを推奨します

## 参考文献

https://github.com/modelcontextprotocol/servers-archived/tree/main/src/slack
