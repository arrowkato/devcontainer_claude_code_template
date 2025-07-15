# CloudWatch MCPサーバー

## 概要

AWS Labs CloudWatch Model Context Protocol (MCP) サーバーは、CloudWatchのテレメトリデータを使用したAI駆動の根本原因分析と推奨事項を提供します。アラームベースのトラブルシューティング、ログ分析、メトリクス定義分析、アラーム推奨などの機能を通じて、Claude CodeからAWSの監視・運用データを直接操作できます。


## このリポジトリでの設定
### 注意
ちょっと気持ち悪いですが、Claude Codeを使うときのBedrockの `.aws.env` に入っており、環境変数としてコンテナに渡されます。

一方で、CloudWatchのMCPサーバーは、以下の設定をしてます。MCPサーバーの設定のほうが後付だったのが理由です。
~/.aws/config, ~/.aws/credentials を設定して、両方に使うほうが普通かと思います。

### .mcp.json

```jsonc
// デフォルトの awslabs.cloudwatch-mcp-server のままだと
// https://github.com/anthropics/claude-code/issues/2485 と同じエラーがでるので、名前を短くしています。
"cloudwatch": {
    "autoApprove": [],
    "disabled": false,
    "command": "uvx",
    "args": [
        "awslabs.cloudwatch-mcp-server@latest"
    ],
    "env": {
        "AWS_PROFILE": "default", // これは、~/.aws/config に存在する項目なら何でもいいです。
        "FASTMCP_LOG_LEVEL": "ERROR"
    },
    "transportType": "stdio"
}
```

### 必要な接続情報
- ~/.aws/config
- ~/.aws/credential

この2つのファイルがコンテナ側で必要なので、
`<repository_root>/private/.aws` 配下に、接続可能なAWSの　config と credentials ファイルをあらかじめ配置してください。
`chmod 600 config credentials` をお忘れなく。

また、接続先で必要なPermissionは、[Required IAM Permissions](https://github.com/awslabs/mcp/tree/main/src/cloudwatch-mcp-server#required-iam-permissions) を参照してください。

### boto3 が読み込める場所に配置
compose.yaml で下記の設定をしています。
```yaml
# AWSのmcpサーバー接続のために接続情報を渡すための設定。
# あらかじめ ../private 配下に coinfg と credentials を配置してください
- type: bind
  source: ../private/.aws/
  target: /root/.aws/
```


## 注意事項
- ログクエリは大量のトークンを消費する可能性があるため、時間範囲と粒度を適切に設定することを推奨します。e.g., 直近1時間

## 参考文献
- [AWS Labs MCP CloudWatch Server](https://github.com/awslabs/mcp/tree/main/src/cloudwatch-mcp-server)

