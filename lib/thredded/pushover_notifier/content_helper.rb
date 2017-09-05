# frozen_string_literal: true

require 'rails'
require 'thredded/engine'
require 'action_view'

# NB not loaded until needed so that it can set up the config
module Thredded
  class PushoverNotifier
    class ContentHelper
      include ActionView::Helpers::TextHelper

      Thredded::Engine.config.to_prepare do
        Thredded::PushoverNotifier::ContentHelper.include Thredded::Engine.routes.url_helpers
      end

      attr_reader :post, :root_url

      def initialize(root_url, post)
        @root_url = root_url
        @post = post
      end

      def message_for_new_topic_post
        content_truncated(replace_images)
      end

      def title_for_new_topic_post
        "#{post.postable.title} by @#{post.user.thredded_display_name} [#{post.messageboard.name}]"
      end

      def post_url
        "#{root_url}#{post_permalink_path(post)}"
      end

      protected

      def replace_images
        post.content.gsub(/!\[[^\]]*?\]\(([^)]*?)\)/, "[IMAGE]")
      end

      def content_truncated(content)
        truncate(content, length: 100, separator: " ")
      end

    end
  end
end
