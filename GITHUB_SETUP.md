# GitHub 接続ガイド

このプロジェクトを GitHub に接続する方法を説明します。

## 方法1: GitHub CLI を使用（推奨・自動化）

### 1. GitHub CLI をインストール

**Homebrew を使用（推奨）:**
```bash
brew install gh
```

**または公式サイトから:**
https://cli.github.com/

### 2. GitHub に接続

```bash
cd /Users/oozora/開発0001
./connect-github.sh
```

このスクリプトが以下を自動で実行します：
- GitHub へのログイン
- Git ユーザー情報の設定
- GitHub リポジトリの作成
- コードのプッシュ

---

## 方法2: 手動で GitHub に接続

### 1. GitHub でリポジトリを作成

1. https://github.com/new にアクセス
2. リポジトリ名を入力（例: `next-app`）
3. Public または Private を選択
4. **重要**: README、.gitignore、ライセンスは追加しない（既に存在するため）
5. 「Create repository」をクリック

### 2. Git ユーザー情報を設定

```bash
cd /Users/oozora/開発0001

# あなたの GitHub ユーザー名とメールアドレスに置き換えてください
git config user.name "あなたのGitHubユーザー名"
git config user.email "あなたのGitHubメールアドレス"
```

### 3. 初回コミット（未コミットの場合）

```bash
git commit -m "Initial commit: Next.js app with PostgreSQL"
```

### 4. リモートリポジトリを追加してプッシュ

```bash
# ブランチ名を main に設定
git branch -M main

# リモートリポジトリを追加（リポジトリ名とユーザー名を置き換えてください）
git remote add origin https://github.com/あなたのユーザー名/リポジトリ名.git

# コードをプッシュ
git push -u origin main
```

---

## 現在の状態

- ✅ Git リポジトリは初期化済み
- ✅ ファイルはステージング済み
- ⚠️ Git ユーザー情報の設定が必要
- ⚠️ 初回コミットが必要（Git ユーザー情報設定後）
- ⚠️ GitHub リポジトリの作成が必要

---

## トラブルシューティング

### Git ユーザー情報が設定されていない

```bash
git config user.name "あなたの名前"
git config user.email "あなたのメールアドレス"
```

### リモートリポジトリが既に存在する

```bash
git remote -v  # 現在のリモートを確認
git remote remove origin  # 既存のリモートを削除
git remote add origin https://github.com/ユーザー名/リポジトリ名.git  # 新しいリモートを追加
```

### 認証エラーが発生する

GitHub の Personal Access Token を使用する場合：
1. https://github.com/settings/tokens でトークンを作成
2. `git push` 時にトークンをパスワードとして入力

または SSH キーを使用：
```bash
git remote set-url origin git@github.com:ユーザー名/リポジトリ名.git
```
