class LinebotController < ApplicationController
    require 'line/bot'
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    events = client.parse_events_from(body)
    events.each { |event|
        case event
        when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          case event.message['text']
          when "男"
            message = [{
            type: 'text',
            text: "じじ"
            }]
          when "女"
            message = [{
            type: 'text',
            text: "まじじ"
            }]
          when "くま"
            message = [{
            type: 'text',
            text: "くま吉プー吉子吉"
            }]
          when "いぬ"
            message = [{
            type: 'text',
            text: "ぶぶ"
            }]
          end
            client.reply_message(event['replyToken'], message)
        end
        end
    }
    head :ok
  end
private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def select_word
    # この中を変えると返ってくるキーワードが変わる
    seeds = ["アイデア１", "アイデア２", "アイデア３", "アイデア４"]
    seeds.sample
  end

end
