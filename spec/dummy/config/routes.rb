# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#show'
  mount Thredded::Engine => '/thredded'
end
