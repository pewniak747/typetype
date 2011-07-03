Typetype::Application.routes.draw do

  root :to => "texts#popular"

  match 'admin' => "admin#index"

  namespace :admin do 
    resources :texts do
      post 'categorize/:category_id' => "texts#categorize", :as => :categorize
      post 'uncategorize/:category_id' => "texts#uncategorize", :as => :uncategorize
    end
    resources :categories
    resources :results, :only => [:index, :update, :destroy]
  end

  scope 'texts', :controller => :texts do
    get 'popular' => "texts#popular", :as => 'popular_texts'
    get 'fresh' => "texts#fresh", :as => 'fresh_texts'
    scope ':id/type', :controller => :results do
      get '/' => "results#new", :as => 'new_result'
      post '/create' => "results#create", :as => 'create_result'
    end
  end
  resources :texts, :only => [:show, :index] 
  resources :categories, :only => [:show, :index]


end
