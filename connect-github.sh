#!/bin/bash
# GitHub 接続スクリプト（GitHub CLI なしでも対応）
set -e

cd "$(dirname "$0")"

echo "=== GitHub 接続セットアップ ==="
echo ""

# 方法1: GitHub CLI を使用（推奨）
if command -v gh &>/dev/null; then
  echo "GitHub CLI が見つかりました。"
  echo ""
  
  # 認証確認
  if ! gh auth status &>/dev/null; then
    echo "GitHub にログインします..."
    gh auth login
  else
    echo "✓ GitHub にログイン済み"
    gh auth status
  fi
  
  # Git ユーザー情報を設定
  GITHUB_USER=$(gh api user -q .login)
  GITHUB_EMAIL=$(gh api user/emails -q '.[] | select(.primary == true) | .email')
  
  if [ -n "$GITHUB_USER" ] && [ -n "$GITHUB_EMAIL" ]; then
    git config user.name "$GITHUB_USER"
    git config user.email "$GITHUB_EMAIL"
    echo "✓ Git ユーザー情報を設定: $GITHUB_USER ($GITHUB_EMAIL)"
  fi
  
  # リポジトリ名を決定
  REPO_NAME=$(basename "$(pwd)")
  read -p "GitHub リポジトリ名 (デフォルト: $REPO_NAME): " INPUT_REPO_NAME
  REPO_NAME=${INPUT_REPO_NAME:-$REPO_NAME}
  
  # 初回コミット（未コミットの場合）
  if ! git rev-parse --verify HEAD &>/dev/null; then
    echo ""
    echo "初回コミットを作成します..."
    git commit -m "Initial commit: Next.js app with PostgreSQL"
  fi
  
  # リポジトリを作成してプッシュ
  echo ""
  echo "GitHub リポジトリを作成します: $REPO_NAME"
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
  
  echo ""
  echo "=== セットアップ完了 ==="
  echo "GitHub リポジトリ: https://github.com/$GITHUB_USER/$REPO_NAME"
  
else
  # 方法2: 手動で GitHub リポジトリを作成
  echo "GitHub CLI がインストールされていません。"
  echo ""
  echo "【手動セットアップ手順】"
  echo ""
  echo "1. GitHub でリポジトリを作成:"
  echo "   https://github.com/new"
  echo "   - リポジトリ名を入力"
  echo "   - Public または Private を選択"
  echo "   - README、.gitignore、ライセンスは追加しない（既に存在するため）"
  echo "   - 「Create repository」をクリック"
  echo ""
  echo "2. 以下のコマンドを実行（リポジトリ名とユーザー名を置き換えてください）:"
  echo ""
  echo "   git config user.name \"あなたのGitHubユーザー名\""
  echo "   git config user.email \"あなたのGitHubメールアドレス\""
  echo "   git commit -m \"Initial commit: Next.js app with PostgreSQL\""
  echo "   git branch -M main"
  echo "   git remote add origin https://github.com/あなたのユーザー名/リポジトリ名.git"
  echo "   git push -u origin main"
  echo ""
  echo "または、GitHub CLI をインストールして自動化:"
  echo "   brew install gh"
  echo "   その後、このスクリプトを再実行"
fi
