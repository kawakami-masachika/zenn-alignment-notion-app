require 'httparty'
require 'json'
require 'date'
require 'dotenv/load'

# 環境変数から機密情報を取得
NOTION_API_KEY = ENV['NOTION_API_KEY']
NOTION_DATABASE_ID = ENV['NOTION_DATABASE_ID']

ZENN_API_ENDPOINT = "https://zenn.dev/api/articles"
NOTION_API_ENDPOINT = "https://api.notion.com/v1/pages"

# 取得したいZennのトピックを指定
TARGET_TOPIC = "ai" # ここを好きなトピック名に変更してください

# Zenn APIから記事を取得するメソッド
def get_zenn_articles(topic)
  puts "Fetching articles for topic: #{topic}..."
  options = {
    query: {
      topicname: topic,
      order: "latest",
      count: 10
    }
  }
  response = HTTParty.get(ZENN_API_ENDPOINT, options)

  unless response.success?
    puts "Error fetching Zenn articles: #{response.message}"
    return []
  end

  articles = response.parsed_response['articles']
  puts "Successfully fetched #{articles.length} articles."
  articles
end

# 取得した記事をNotionデータベースに追加するメソッド
def add_article_to_notion(article)
  headers = {
    "Authorization" => "Bearer #{NOTION_API_KEY}",
    "Content-Type" => "application/json",
    "Notion-Version" => "2022-06-28"
  }

  # Notionデータベースのプロパティ名に合わせてキーを調整してください
  properties = {
    "タイトル": { title: [{ text: { content: article["title"] } }] },
    "URL": { url: "https://zenn.dev#{article['path']}" },
    "投稿日": { date: { start: Date.iso8601(article["published_at"]).strftime('%Y-%m-%d') } },
    "いいね数": { number: article["liked_count"] },
    "トピック": { multi_select: (article["topics"] || []).map { |t| { name: t["name"] } } }
  }

  body = {
    parent: { database_id: NOTION_DATABASE_ID },
    properties: properties
  }.to_json

  puts JSON.parse(body)

  response = HTTParty.post(NOTION_API_ENDPOINT, headers: headers, body: body)

  if response.success?
    puts "Successfully added '#{article['title']}' to Notion."
  else
    puts "Error adding article to Notion: #{response.body}"
  end
end

# メイン処理
articles = get_zenn_articles(TARGET_TOPIC)

def main
  # トピックを標準入力で受け取る
  puts "Enter a topic to fetch articles from Zenn (default: 'ruby'):"
  topic = gets.chomp
  topic = "ruby" if topic.strip.empty? # 入力が空の場合はデフォルト値を使用

  # Notionへのアクションを標準入力で受け取る
  puts "Enter an action for Notion (add or skip, default: 'add'):"
  action = gets.chomp.downcase
  action = "add" if action.strip.empty? # 入力が空の場合はデフォルト値を使用

  # Zennの記事を取得
  articles = get_zenn_articles(topic)

  # アクションに応じて処理を実行
  if action == "add"
    articles.each do |article|
      add_article_to_notion(article)
    end
  else
    puts "Skipping Notion action."
  end
end

# TODO: 重複チェック処理をここに実装することを推奨します

# mainメソッドを呼び出す
main