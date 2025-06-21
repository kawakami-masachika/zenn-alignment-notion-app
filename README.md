# Zenn Alignment Notion App

## 概要
このアプリケーションは、Zennから指定したトピックの記事を取得し、Notionデータベースに追加するRubyスクリプトです。標準入力を通じてトピックやアクションを指定することで、柔軟に操作できます。

## Rubyのバージョン
このプロジェクトは以下のRubyバージョンで動作します:
- **Ruby 3.1.6** (推奨)

## 使用しているライブラリ
以下のGemを使用しています:
- **rake**: タスク管理とバッチ処理用
- **dotenv**: 環境変数の管理
- **httparty**: HTTPリクエストを簡単に扱うためのライブラリ
- **notion_ruby**: Notion APIとの連携用

## スクリプトの概要
1. Zenn APIを使用して、指定したトピックの記事を取得します。
2. Notion APIを使用して、取得した記事をNotionデータベースに追加します。
3. 標準入力を通じてトピックやアクションを指定できます。
   - トピック: Zennから取得する記事のカテゴリ
   - アクション: Notionに記事を追加するかスキップするか

## 起動するまでの手順
1. **リポジトリをクローン**
   ```bash
   git clone https://github.com/your-repository/zenn-alignment-notion-app.git
   cd zenn-alignment-notion-app
   ```

2. **必要なGemをインストール**
   ```bash
   bundle install
   ```

3. **環境変数を設定**
   `.env`ファイルを作成し、以下の内容を記述してください:
   ```
   NOTION_API_KEY=your_notion_api_key
   NOTION_DATABASE_ID=your_notion_database_id
   ```

4. **スクリプトを実行**
   ```bash
   ruby main.rb
   ```

5. **標準入力で操作**
   - トピックを入力 (例: `ruby`)
   - アクションを入力 (`add` または `skip`)

## 注意事項
- Notionデータベースのプロパティ名はスクリプト内で調整してください。
- Zenn APIの仕様変更があった場合、スクリプトの修正が必要になる可能性があります。

## ライセンス
このプロジェクトはMITライセンスのもとで公開されています。
