# Next.js アプリ

Node.js / npm / Next.js / PostgreSQL を使ったアプリの環境です。

## 必要な環境

- **Node.js**: 20.9 以上（推奨: LTS）
- **npm**: 10 以上（Node.js に同梱）
- **PostgreSQL**: 14 以上（推奨: 16）

## 自動セットアップ（推奨）

ターミナルで以下を実行すると、Node.js（未インストール時は nvm 経由で導入）と npm パッケージをまとめてセットアップできます。

```bash
cd /Users/oozora/開発0001
chmod +x setup.sh
./setup.sh
```

## PostgreSQL のセットアップ

1. PostgreSQL がインストールされていることを確認:
   ```bash
   psql --version
   ```

2. データベースを作成:
   ```bash
   createdb nextapp
   # または psql で: CREATE DATABASE nextapp;
   ```

3. `.env` ファイルを編集して `DATABASE_URL` を設定:
   ```bash
   cp .env.example .env
   # .env を編集: DATABASE_URL="postgresql://ユーザー名:パスワード@localhost:5432/nextapp"
   ```

4. Prisma スキーマをデータベースに適用:
   ```bash
   npm run db:push
   ```

## 手動セットアップ

すでに Node.js が入っている場合:

```bash
cd /Users/oozora/開発0001
npm install
npx prisma generate
```

## 開発サーバー

```bash
npm run dev
```

ブラウザで [http://localhost:3000](http://localhost:3000) を開いてください。

## その他のコマンド

| コマンド | 説明 |
|----------|------|
| `npm run build` | 本番用ビルド |
| `npm run start` | ビルド後の本番サーバー起動 |
| `npm run lint` | ESLint でコードチェック |
| `npm run db:generate` | Prisma Client を生成 |
| `npm run db:push` | スキーマをデータベースに適用（開発用） |
| `npm run db:migrate` | マイグレーションを作成・適用 |
| `npm run db:studio` | Prisma Studio を起動（GUI でデータベースを確認） |

## プロジェクト構成

- `app/` - App Router（ページ・レイアウト）
  - `app/layout.tsx` - ルートレイアウト
  - `app/page.tsx` - トップページ
  - `app/api/users/route.ts` - ユーザー API エンドポイント（サンプル）
  - `app/globals.css` - グローバルスタイル
- `lib/db.ts` - Prisma Client のシングルトンインスタンス
- `prisma/schema.prisma` - データベーススキーマ定義
- `.env.example` - 環境変数のテンプレート

## API エンドポイント（サンプル）

- `GET /api/users` - ユーザー一覧を取得
- `POST /api/users` - 新しいユーザーを作成（body: `{ email: string, name?: string }`）
