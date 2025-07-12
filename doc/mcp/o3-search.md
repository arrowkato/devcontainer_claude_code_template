# o3 MCPサーバー

## 概要

OpenAIのo3モデルを用いた`ウェブ検索機能`を提供するMCP（Model Context Protocol）サーバーです。

## このリポジトリでの設定

o3 MCPサーバーは`.mcp.json`で設定され、OpenAI APIキーが必要です。

```json
{
  "mcpServers": {
    "o3-search": {
      "command": "npx",
      "args": ["o3-search-mcp"],
      "env": {
        "SEARCH_CONTEXT_SIZE": "medium",
        "REASONING_EFFORT": "medium",
        "OPENAI_API_KEY": "${OPENAI_API_KEY}"
      }
    }
  }
}
```
`.mcp.json` ファイル上の `OPENAI_API_KEY` は、コンテナ上の環境変数です。
compose.yaml を参照してください。

もととなる値は、 `.env` ファイルで設定しています。
```ini
OPENAI_API_KEY=your_openai_api_key_here
```

### 設定パラメータ

- OPENAI_API_KEY (必須): OpenAI APIキー
- SEARCH_CONTEXT_SIZE（オプション）: 検索コンテキストのサイズを制御します
  - 値: low、、mediumhigh
  - デフォルト：medium
- REASONING_EFFORT（オプション）：推論努力レベルを制御する
  - 値: low、、mediumhigh
  - デフォルト：medium
- OPENAI_API_TIMEOUT (オプション): APIリクエストのタイムアウト(ミリ秒)
  - デフォルト: 60000(60秒)
  - 例: 120000 (2分間)
- OPENAI_MAX_RETRIES (オプション): 失敗したリクエストの最大再試行回数
  - デフォルト：3
  - SDKはレート制限（429）、サーバーエラー（5xx）、接続エラーが発生すると自動的に再試行します。

### 参考文献
https://github.com/yoshiko-pg/o3-search-mcp
