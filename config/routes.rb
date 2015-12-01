Rails.application.routes.draw do
  devise_for :participants, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  #devise_for :admin_users
  devise_for :admin_user
  # devise_scope :admin_user do
    # get "/" => "devise/sessions#new"
  # end
  # match 'auth/:provider/callback', to: 'facebook_logins#create'
  # match 'auth/failure', to: redirect('/')
  
  match ':status' , to: 'errors#show' , constraints: {status: /\d{3}/} ,via: :all
  
  # root :to => "homepages#front_page"
  devise_scope :admin_user do 
    get "" => "devise/sessions#new" 
  end
  
  resources :homepages do
    collection do
      get :front_page
      get :privacy_policy
    end
  end 
  
  resources :clients
  
  resources :sweepstakes do
    collection do
      post :submit_for_approval
      post :approve_sweepstake
      get :themes
      get :theme_select
      get :email_link
      post :send_email_link
      get :reject_sweepstake
      get :preview
    end
  end
  
  get "display/:secure_key", to: "sweepstakes#display"
  get "application/download_pdf"
  resources :dashboards
  
  resources :participants do
    collection do
      get :view_participant 
      get :view_winners
      get :random_winner
      get :manual_winner
      get :email_winner
      post :register
      get :all_winners
      get :winner_list
    end
  end
  
  resources :admins
  
  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

end
