require 'json'
require 'httparty'
require 'date'
require 'dotenv/load'

class NotionBaseService
  # 環境変数から機密情報を取得
  NOTION_API_KEY = ENV['NOTION_API_KEY']
  NOTION_DATABASE_ID = ENV['NOTION_DATABASE_ID']
  NOTION_API_ENDPOINT = "https://api.notion.com/v1/pages"

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
      "トピック": { multi_select: (article["topics"] || []).map { |t| { name: t["name"] } } },
      "追加日": { date: { start: Date.today.strftime('%Y/%m/%d') } }
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
end