require 'httparty'

class ZennBaseService
  ZENN_API_ENDPOINT = "https://zenn.dev/api/articles".freeze # Zenn APIのエンドポイント
  DEFAULT_COUNT = 10.freeze # デフォルトで取得する記事数

  def initialize(options)
    @count = options[:count] || DEFAULT_COUNT
    @topic = options[:topic]
  end

  # Zenn APIから記事を取得するメソッド
  def get_zenn_articles
    puts "「#{topic}」トピックの記事を取得中... (最大 #{@count} 件)"
    options = {
      query: {
        topicname: topic,
        order: "latest",
        count: @count
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

  private
  attr_reader :count, :topic
end
