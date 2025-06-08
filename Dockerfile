# Ruby 3.1系の最新バージョンをベースイメージとして使用
FROM ruby:3.1

# 作業ディレクトリを設定
WORKDIR /app

# 必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerをインストールし、依存関係を解決
RUN bundle install

# アプリケーションコードをコピー
COPY . .

# サーバーを起動するコマンドを指定（例: Railsの場合）
CMD ["ruby", "main.rb"]