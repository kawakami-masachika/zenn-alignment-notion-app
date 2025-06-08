require 'httparty'

class ZennBaseService
  ZENN_API_ENDPOINT = "https://zenn.dev/api/articles"

  def initialize; end

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
end
