#!/bin/bash
# Node.js / npm / Next.js 自動セットアップスクリプト
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Node.js / npm / Next.js セットアップ ==="

# Node.js が未インストールなら nvm でインストール
if ! command -v node &>/dev/null; then
  echo "Node.js が見つかりません。nvm でインストールします..."
  export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
  if [ ! -d "$NVM_DIR" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  fi
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install --lts
  nvm use --lts
fi

echo "Node: $(node -v)"
echo "npm:  $(npm -v)"

# 依存関係をインストール
echo ""
echo "npm install を実行しています..."
npm install

# Prisma Client を生成
echo ""
echo "Prisma Client を生成しています..."
npx prisma generate

# .env ファイルが存在しない場合は .env.example からコピー
if [ ! -f .env ]; then
  echo ""
  echo ".env ファイルを作成しています..."
  cp .env.example .env
  echo "⚠️  .env ファイルの DATABASE_URL を PostgreSQL の接続情報に合わせて編集してください"
fi

echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "📝 次のステップ:"
echo "1. .env ファイルの DATABASE_URL を PostgreSQL の接続情報に設定"
echo "2. データベースを作成（例: createdb nextapp）"
echo "3. スキーマを適用: npm run db:push"
echo ""
echo "🚀 開発コマンド:"
echo "開発サーバー起動: npm run dev"
echo "Prisma Studio:    npm run db:studio"
echo "ビルド:           npm run build"
echo "本番起動:         npm run start"
