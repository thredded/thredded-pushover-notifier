# frozen_string_literal: true

Thredded.user_class = 'User'
Thredded.user_name_column = :name
Thredded.user_path = ->(user) { main_app.user_path(user.id) }
Thredded.current_user_method = :"the_current_#{Thredded.user_class_name.underscore}"
Thredded.email_from = 'no-reply@example.com'
Thredded.email_outgoing_prefix = '[Thredded] '
Thredded.layout = 'application' unless ENV['THREDDED_DUMMY_LAYOUT_STANDALONE']
Thredded.avatar_url = ->(user) { Gravatar.src(user.email, 156, 'retro') }
Thredded.moderator_column = :admin
Thredded.admin_column = :admin
Thredded.content_visible_while_pending_moderation = true
Thredded.parent_mailer = 'ApplicationMailer'

Thredded::Engine.config.to_prepare do
  require 'thredded/pushover_notifier/content_helper'
  Thredded::PushoverNotifier::ContentHelper.include Thredded::Engine.routes.url_helpers
  Thredded.notifiers = [Thredded::PushoverNotifier.new(ENV['PUSHOVER_APP_TOKEN'], 'http://example.com')]
end
