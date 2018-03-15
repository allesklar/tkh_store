Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    resources :products do
      member do
        post  :publish
        post  :unpublish
      end
      collection do
        get   :reorder
        post  :sort
      end
    end
    post 'search_for_product_images', to: 'products#search_for_images', :defaults => { :format => 'js' }
    post 'add_image_to_product',      to: 'products#add_image_to',      :defaults => { :format => 'js' }
    post 'remove_image_from_product', to: 'products#remove_image_from', :defaults => { :format => 'js' }

  end
end
