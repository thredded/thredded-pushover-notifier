# frozen_string_literal: true

require 'net/https'

module Thredded
  class PushoverNotifier
    VERSION = '0.1.0'

    def initialize(pushover_app_token, root_url)
      @pushover_app_token = pushover_app_token
      @root_url = root_url
    end

    def key
      'pushover'
    end

    def human_name
      I18n.t('pushover_notifier.by_pushover')
    end

    def new_post(post, users)
      require 'thredded/pushover_notifier/content_helper'
      helper = Thredded::PushoverNotifier::ContentHelper.new(@root_url, post)
      args = [helper.message_for_new_topic_post, helper.title_for_new_topic_post, helper.post_url]
      users.map(&:pushover_user_key).each do |user_key|
        send_message(user_key, *args) if user_key.present?
      end
    end

    def new_private_post; end

    def send_message(user_key, message, title, url)
      pushover_url = URI.parse('https://api.pushover.net/1/messages.json')
      req = Net::HTTP::Post.new(pushover_url.path)
      data = {
        token: @pushover_app_token,
        user: user_key,
        message: message,
        title: title,
        url: url,
        url_title: 'View topic'
      }
      req.set_form_data(data)
      res = Net::HTTP.new(pushover_url.host, pushover_url.port)
      res.use_ssl = true
      res.verify_mode = OpenSSL::SSL::VERIFY_PEER
      res.start { |http| http.request(req) }
    end
  end
end
