# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      resources :companies, only: [:index] do
        collection do
          get :list_industries
        end
      end
    end
  end

  get "*path" => "home#index", constraints: ->(request) { request.format == :html }

  root to: "home#index"
end
