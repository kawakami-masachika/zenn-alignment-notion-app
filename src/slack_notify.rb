require 'slack-ruby-client'

class SlackNotify
  def initialize(channel_id, message_builder)
    @channel_id = channel_id
    @message_builder = message_builder
    configure_slack_client
  end

  def send_message
    message = @message_builder.build_message
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: @channel_id, text: message, as_user: true)
  end

  private

  def configure_slack_client
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end
end



