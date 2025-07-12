# Context7 MCPサーバー

## 概要

Context7 MCPサーバーは、ライブラリとフレームワークの最新ドキュメントへのアクセスを提供します。
LLMに特に指示しない場合、古い

## 設定

Context7 MCPサーバーは`.mcp.json`で設定されます
このMCPサーバーはAPIキーや追加設定は不要です。
```json
{
  "mcpServers": {
    "context7": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {}
    }
  }
}
```


## このリポジトリ特有の設定

Context7で取得したドキュメントはcacheを目的として、`.claude/private/context7/` に保存して、利用する旨を `CLAUDE.md` に記載しています。
該当箇所は下記のとおりです。

```markdown
### Context7 Documentation Management

Context7 MCP server provides access to up-to-date library documentation. Retrieved documentation is saved locally for reference:

- **Storage Location**: `.claude/private/context7/`
- **Usage**: Documentation retrieved via context7 is automatically saved as Markdown files
- **Purpose**: Enables offline access to library documentation and maintains a knowledge base of retrieved information
- **Best Practice**: Refer to saved documentation when working with libraries to ensure consistency and reduce API calls
```

## 参考文献
https://github.com/upstash/context7
