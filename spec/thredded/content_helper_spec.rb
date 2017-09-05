# frozen_string_literal: true

require 'spec_helper'
require 'thredded/pushover_notifier/content_helper'

describe Thredded::PushoverNotifier::ContentHelper do
  let(:root_url) {'http://localhost:3000/'}
  let(:post) { double(:post, postable: topic, content: "The problem with these prototypes is that they are too blue
.", messageboard: messageboard, user: author) }
  let(:author) { double(:user, thredded_display_name: "myauthor") }
  let(:topic) { double(:topic, title: "BXH prototypes") }
  let(:messageboard) { double(:messageboard, name: 'messageboard-name')}

  subject { Thredded::PushoverNotifier::ContentHelper.new(root_url, post) }
  describe "#title_for_new_topic_post" do
    subject{ super().title_for_new_topic_post }

    it "can compose a title for a post" do
      expect(subject).to include("BXH prototypes")
    end
  end

  describe "#message_for_new_topic_post" do
    subject{ super().message_for_new_topic_post }

    it "can compose a message for a post" do
      expect(subject).to include("problem with these prototypes")
    end

    context "with a post with an image" do
      let(:post) { double(:post, postable: topic, content: "Hmmm ![Image](https://example.com/path/image.jpeg)", user: author, messageboard: messageboard) }
      it "replaces the image tag with [IMAGE]" do
        expect(subject).to eq("Hmmm [IMAGE]")
      end
    end

    context "with a post with two images" do
      let(:post) { double(:post, postable: topic, content: "Hmmm ![Image](https://example.com/path/image.jpeg) some text ![Image](https://example.com/otherpath/otherimage.png)", user: author, messageboard: messageboard) }
      it "replaces the image tag with [IMAGE]" do
        expect(subject).to eq("Hmmm [IMAGE] some text [IMAGE]")
      end
    end
  end

  describe "#post_url" do
    before do
      # simulate actually working routes which get loaded by
      subject.define_singleton_method(:post_permalink_path) do |post|
        "/posts/whatever"
      end
    end
    it "begins with root_url" do
      expect(subject.post_url).to start_with(root_url)
    end

    it "has posts" do
      expect(subject.post_url).to include("/posts")
    end
  end
end
