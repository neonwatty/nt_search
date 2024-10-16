Rails.application.routes.draw do
  # Search route
  get "search", to: "new_test_words#search"

  # Resources for 'new_test_words' with custom collection route
  resources :new_test_words, except: [:create, :show, :update, :edit, :new, :destroy] do
    collection do
      get "search" # Use GET for search, typically for form submissions
      post "search", to: "new_test_words#search" # If you want to allow POST too
    end
  end

  # Set the root path to the search action
  root to: 'new_test_words#search'
end
