#!/bin/bash
# GitHub 接続用セットアップスクリプト
set -e

cd "$(dirname "$0")"

echo "=== GitHub 接続セットアップ ==="
echo ""

# GitHub CLI のインストール確認
if ! command -v gh &>/dev/null; then
  echo "GitHub CLI がインストールされていません。"
  echo ""
  echo "インストール方法（いずれか）:"
  echo "1. Homebrew を使用:"
  echo "   brew install gh"
  echo ""
  echo "2. 公式インストーラーを使用:"
  echo "   https://cli.github.com/"
  echo ""
  read -p "GitHub CLI をインストールしましたか？ (y/n): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "GitHub CLI のインストールが必要です。"
    exit 1
  fi
fi

# GitHub CLI で認証
echo "GitHub にログインします..."
gh auth login

# Git ユーザー情報を設定（GitHub アカウントから取得）
GITHUB_USER=$(gh api user -q .login)
GITHUB_EMAIL=$(gh api user/emails -q '.[] | select(.primary == true) | .email')

if [ -n "$GITHUB_USER" ] && [ -n "$GITHUB_EMAIL" ]; then
  git config user.name "$GITHUB_USER"
  git config user.email "$GITHUB_EMAIL"
  echo "✓ Git ユーザー情報を設定しました: $GITHUB_USER ($GITHUB_EMAIL)"
fi

# リポジトリ名を決定
REPO_NAME=$(basename "$(pwd)")
read -p "GitHub リポジトリ名 (デフォルト: $REPO_NAME): " INPUT_REPO_NAME
REPO_NAME=${INPUT_REPO_NAME:-$REPO_NAME}

# リポジトリを作成
echo ""
echo "GitHub リポジトリを作成します: $REPO_NAME"
gh repo create "$REPO_NAME" --public --source=. --remote=origin --push

echo ""
echo "=== セットアップ完了 ==="
echo "GitHub リポジトリ: https://github.com/$GITHUB_USER/$REPO_NAME"
