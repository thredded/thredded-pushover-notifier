# frozen_string_literal: true

require 'spec_helper'

describe Thredded::PushoverNotifier::ContentHelper do
  let(:configured_root_url) { 'http://localhost:3000/' }
  let(:post) do
    double(:post, postable: topic, content: "The problem with these prototypes is that they are too blue
.", messageboard: messageboard, user: author)
  end
  let(:author) { double(:user, thredded_display_name: 'myauthor') }
  let(:topic) { double(:topic, title: 'BXH prototypes') }
  let(:messageboard) { double(:messageboard, name: 'messageboard-name') }

  subject { Thredded::PushoverNotifier::ContentHelper.new(configured_root_url, post) }
  describe '#title_for_new_topic_post' do
    subject { super().title_for_new_topic_post }

    it 'can compose a title for a post' do
      expect(subject).to include('BXH prototypes')
    end
  end

  describe '#message_for_new_topic_post' do
    subject { super().message_for_new_topic_post }

    it 'can compose a message for a post' do
      expect(subject).to include('problem with these prototypes')
    end

    context 'with a post with an image' do
      let(:post) do
        double(:post, postable: topic, user: author, messageboard: messageboard,
                      content: 'Hmmm ![Image](https://example.com/path/image.jpeg)')
      end
      it 'replaces the image tag with [IMAGE]' do
        expect(subject).to eq('Hmmm [IMAGE]')
      end
    end

    context 'with a post with two images' do
      let(:post) do
        double(:post, postable: topic, user: author, messageboard: messageboard,
                      content: <<~CONTENT
                        Hmmm ![Image](https://example.com/path/image.jpeg) some text
                        ![Image](https://example.com/otherpath/otherimage.png)
                      CONTENT
              )
      end
      it 'replaces the image tag with [IMAGE]' do
        expect(subject).to eq(
          <<~CONTENT
            Hmmm [IMAGE] some text
            [IMAGE]
          CONTENT
      )
      end
    end
  end

  describe '#post_url' do
    let(:post) { double(:post, postable: topic, user: author, id: 1234) }

    it 'begins with root_url' do
      expect(subject.post_url).to start_with(configured_root_url)
    end

    it 'has posts' do
      expect(subject.post_url).to include('/posts')
    end

    it 'is exact' do
      configured_thredded_mount_point = 'thredded' # configured in your routes.rb
      expect(subject.post_url).to eq("#{configured_root_url}/#{configured_thredded_mount_point}/posts/1234")
    end
  end
end
