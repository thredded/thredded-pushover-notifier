# frozen_string_literal: true

require 'rails'
require 'action_view'

module Thredded
  class PushoverNotifier
    class ContentHelper
      include ActionView::Helpers::TextHelper

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
        "#{root_url}#{post_permalink_path(post.id)}"
      end

      protected

      def replace_images
        post.content.gsub(/!\[[^\]]*?\]\(([^)]*?)\)/, '[IMAGE]')
      end

      def content_truncated(content)
        truncate(content, length: 100, separator: ' ')
      end
    end
  end
end
