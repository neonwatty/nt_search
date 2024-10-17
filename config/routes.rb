Rails.application.routes.draw do

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Search route
  get "search", to: "new_test_verses#search"

  # Resources for 'new_test_verses' with custom collection route
  resources :new_test_verses, except: [:create, :show, :update, :edit, :new, :destroy] do
    collection do
      post "search_items"
    end
  end

  # Set the root path to the search action
  root 'new_test_verses#search'
end
