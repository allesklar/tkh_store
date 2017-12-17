Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    resources :products do
      member do
        post :publish
        post :unpublish
      end
      collection do
        get :reorder
        post :sort
      end
    end

  end
end
