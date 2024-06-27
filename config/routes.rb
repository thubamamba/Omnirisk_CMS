# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  draw :accounts
  draw :api
  draw :billing
  draw :turbo_native
  draw :users
  draw :dev if Rails.env.local?

  authenticated :user, lambda { |u| u.admin? } do
    draw :admin
    mount Flipper::UI.app(Flipper) => "/flipper", :as => :flipper_ui
  end

  resources :announcements, only: [:index, :show]

  namespace :action_text do
    resources :embeds, only: [:create], constraints: {id: /[^\/]+/} do
      collection do
        get :patterns
      end
    end
  end

  # resources :damaged_items
  # resources :witnesses
  # resources :comments
  # resources :municipalities
  resources :claims do
    resources :comments, only: [:new, :create]
    member do
      delete :delete_property_claim_photos
    end
  end

  scope controller: :static do
    # get :about
    get :terms
    get :privacy
    get :pricing
  end

  # Removes the sign up page
  post "/users/sign_up", to: redirect('/')
  get "/users/sign_up", to: redirect('/')

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "claims#index", as: :user_root
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # Public marketing homepage
  root to: "static#index"
end
