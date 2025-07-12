# GitHub MCPサーバー

## 概要

GitHub MCPサーバーは、GitHubのAPIとの包括的な統合を提供し、開発環境から直接リポジトリ、Issue、プルリクエスト、ワークフロー、その他のGitHub機能とやり取りできるようにClaude Codeを有効にします。


## 設定

GitHub MCPサーバーはDockerコンテナとして動作し、Personal Access Tokenが必要です。

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

### 必要な環境変数

`.env`ファイルに以下の設定が必要です：

```bash
GITHUB_PERSONAL_ACCESS_TOKEN=your_token_here
```

### Docker要件

このMCPサーバーはGitHubの公式Dockerイメージ（`ghcr.io/github/github-mcp-server`）を使用します。
`docker/Dockerfile` の `uv_base` を使ったコンテナならば、Dockerをインストール済みです。

実は docker/Dockerfile では、GitHubのMCPサーバーとは別に、`gh` コマンドもインストールしています。

## GitHubのToken設定

1. 以下の2ついずれかの方法でtokenを作成してください
  - 推奨: https://github.com/settings/personal-access-tokens で Fine-grained tokenを作成
  - 非推奨: https://github.com/settings/tokens で Personal access tokenを作成
2. `.env`ファイルに`GITHUB_PERSONAL_ACCESS_TOKEN`としてトークンを追加

MCPのサーバーの機能は、[tool-configuration](https://github.com/github/github-mcp-server?tab=readme-ov-file#tool-configuration) を参照してください。
Fine-grained tokenで利用したいorganization, repository, permission で最小限の権限を設定することを推奨します。

permissions設定で迷ったら下記あたりがあれば、それなりに開発できると思います。
- Repository permissions
  - Contents: Read and write
  - Issues: Read and write
  - Pull requests: Read and write
- Account permissions
  - 全項目: No access

## GitHub MCPサーバーと gh コマンドの使い分け
ghコマンドの方がAPIに近くて、厳密です。
また、.claude/settings.json および .claude/settings.local.json で、許可するコマンドと拒否するコマンドを設定しやすいです。(MCPサーバーも許可と拒否はできます)


## 参考文献
https://github.com/github/github-mcp-server
