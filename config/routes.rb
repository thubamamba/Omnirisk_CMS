# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :damaged_items
  resources :witnesses
  resources :comments
  resources :claims do
    resources :comments, only: [:new, :create]
    member do
      delete :delete_property_claim_photos
    end
  end
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
  resources :municipalities

  namespace :action_text do
    resources :embeds, only: [:create], constraints: {id: /[^\/]+/} do
      collection do
        get :patterns
      end
    end
  end

  scope controller: :static do
    get :about
    get :terms
    get :privacy
    get :pricing
  end

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "claims#index", as: :user_root
    # Alternate route to use if logged in users should still see public root
    # get "/dashboard", to: "dashboard#show", as: :user_root
  end

  # devise_scope :user do
  #   authenticated :user do
  #     root 'dashboard#show', as: :authenticated_root
  #   end

    # unauthenticated do
    #   root 'devise/sessions#new', as: :unauthenticated_root
    # end
  # end
  # Non authenticated users go to login page
  # devise_scope :user do
  #   root to: "devise/sessions#new", as: :unauthenticated_root
  # end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # Public marketing homepage
  root to: "static#index"
end
