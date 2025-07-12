# devcontainer_claude_code_template
クリーンな開発環境を提供するために以下の要素を使って構築しました。
- Devcontainer
- Claude Code
    - AWS Bedrockでの利用を想定
    - MCPサーバで利用する API Keyやtokenは外部から渡すことを想定
- Python
  - uv
  - ruff
  - ty


## 環境設定

### 必要な環境

- Docker & Docker Compose
- VS Code またはそれをforkしたエディタ
- Git
- AWS アカウント
  - BedrockでClaudeを有効化していること または
- (MCPでo3 searchを使うなら) OpenAIのAPI Key

### セットアップ手順

#### 1. リポジトリのクローン
```bash
git clone devcontainer_claude_code_template
cd devcontainer_claude_code_template
```


#### 2. AWS設定（Claude Code を Bedrock 経由で使用する場合）
Claude CodeをBedrock経由で使用する場合は、AWS認証情報を設定する必要があります。

`.aws.env` ファイルを作成する。

```bash
cp .env.example .env
```

AWS認証情報およびClaudeが使用するLLMの設定をしてください。
LLMはリージョンごとに有効化する必要があります。 `AWS_REGION` で指定したリージョンで有効化してください。

`.aws.env` ファイルの内容を編集します
```ini
AWS_ACCESS_KEY_ID=<your-access-key-id>
AWS_SECRET_ACCESS_KEY=<your-secret-access-key>
AWS_DEFAULT_REGION=<your-default-region>

# Bedrockを使う設定。使わない場合は、設定しなくてOK
CLAUDE_CODE_USE_BEDROCK=1

# 使用するモデルの指定(あらかじめBedrock側で有効化してください)
ANTHROPIC_MODEL="us.anthropic.claude-sonnet-4-20250514-v1:0"
ANTHROPIC_SMALL_FAST_MODEL="us.anthropic.claude-3-5-haiku-20241022-v1:0"

# Bedrock統合を有効化
CLAUDE_CODE_USE_BEDROCK=1
AWS_REGION=<your-region>

```

.aws.env自体は、compose.yamlで指定して、コンテナに情報を渡します。

#### 3. 環境変数の設定

AWSやClaude以外の環境変数を設定するために、`.env` ファイルを使用します。
このリポジトリでは、o3 search MCP サーバーを使用するための `OPENAI_API_KEY` と、gh コマンド用の `GITHUB_TOKEN` を設定しています。

`.env` ファイルを作成し、以下の環境変数を設定してください：

```bash
cp .env.example .env
```

`.env` ファイルの内容を編集します：

```ini
# OpenAI API Key
OPENAI_API_KEY="your-openai-api-key-here"

# GitHub Token (gh コマンド用)
GITHUB_TOKEN="your-github-token-here"
```

`.env` ファイルもcompose.yamlで指定して、コンテナに情報を渡しています。


#### 4. 開発環境の起動
起動の前に、CPUを調べてください。
`Dockerfile` で `AWS CLI` コマンドをinstallしていますが、aarch64 向けのAWS CLIを現状では設定しています。
x86_64 CPUを使用している場合は、`Dockerfile` を修正してください。

**Devcontainerの起動**

Macの場合 Cmd+Shift+P を押して、コマンドパレットを開き、「Dev Containers: Container Without Cache and Reopen in Container」を選択します。
Windowsの場合 Ctrl+Shift+P を押して、コマンドパレットを開き、「Dev Containers: Container Without Cache and Reopen in Container」を選択します。


**`docker compose`での起動**  
```bash
docker compose up -d --build
```


### プロジェクト構成

- `pyproject.toml` - Python プロジェクト設定
- `compose.yaml` - Docker Compose 設定
- `Dockerfile` - Docker イメージ定義
- `.mcp.json` - Claude Code MCP サーバー設定

### 開発環境の特徴

- Python 3.13 ベース
- uv パッケージマネージャー使用
- Claude Code CLI プリインストール
- AWS CLI v2 プリインストール
- 開発用ツール（vim等）含む

### 注意事項

- 環境変数ファイル（`.env`, `.aws.env`）は秘密情報を含むため、Gitにコミットしないでください
- Claude Code を使用する際は、AWS認証情報が必要です
- MCPサーバーで、API Keyやtokenを利用する場合は、`.env` ファイル等に記載して、環境変数でコンテナに渡すこと推奨します
- `ty` はまだ、alpha版のため、本番環境での利用は推奨されません
