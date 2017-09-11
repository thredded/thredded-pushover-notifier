# frozen_string_literal: true

require 'spec_helper'

describe Thredded::PushoverNotifier do
  it 'has a version number' do
    expect(Thredded::PushoverNotifier::VERSION).not_to be nil
  end

  let(:root_url) { 'http://localhost:3000/' }
  let(:pushover_user) { double(:user, pushover_user_key: 'one-two') }
  let(:post) do
    double(:post, postable: topic, content: "The problem with these prototypes is that they are too blue
.", user: author, messageboard: messageboard)
  end
  let(:author) { double(:user, thredded_display_name: 'myauthor') }
  let(:topic) { double(:topic, title: 'BXH prototypes') }
  let(:messageboard) { double(:messageboard, name: 'messageboard-name') }

  subject { Thredded::PushoverNotifier.new(ENV['PUSHOVER_APP_TOKEN'], root_url) }

  it 'validates as a Thredded notifier' do
    require 'thredded/base_notifier.rb'
    Thredded::BaseNotifier.validate_notifier(subject)
  end

  describe '#new_post' do
    let(:helper) do
      instance_double(
        Thredded::PushoverNotifier::ContentHelper,
        post_url: 'a link',
        message_for_new_topic_post: 'some message',
        title_for_new_topic_post: 'some title'
      )
    end
    let(:user_without_user_key) { double(:user, pushover_user_key: '') }

    it 'can send a pushover message to right users' do
      expect(subject).to receive(:send_message).with('one-two', 'some message', 'some title', 'a link')
      expect(Thredded::PushoverNotifier::ContentHelper).to receive(:new).with(root_url, post).and_return(helper)
      subject.new_post(post, [pushover_user])
    end

    it 'skips users with no pushover key' do
      expect(subject).not_to receive(:send_message)
      expect(Thredded::PushoverNotifier::ContentHelper).to receive(:new).with(root_url, post).and_return(helper)
      subject.new_post(post, [user_without_user_key])
    end
  end
end
