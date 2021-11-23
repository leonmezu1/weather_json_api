# frozen_string_literal: true

Rails.application.routes.draw do
  delete 'erase', to: 'weather#delete'
  get 'weather', to: 'weather#index'
  post 'weather', to: 'weather#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
