require_relative './src/zenn_base_service'
require_relative './src/notion_base_service'
# 取得したいZennのトピックを指定
TARGET_TOPIC = "ai" # ここを好きなトピック名に変更してください

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
  articles = ZennBaseService.new.get_zenn_articles(topic)
  notion = NotionBaseService.new

  # アクションに応じて処理を実行
  if action == "add"
    articles.each do |article|
      notion.add_article_to_notion(article)
    end
  else
    puts "Skipping Notion action."
  end
end

# TODO: 重複チェック処理をここに実装することを推奨します

# mainメソッドを呼び出す
main