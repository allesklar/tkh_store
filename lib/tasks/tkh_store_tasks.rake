namespace :tkh_store do
  desc "Create migrations and locale files"
  task :install do
    system 'rails g tkh_store:create_or_update_migrations'
    system 'rails g tkh_store:create_or_update_locales -f'
  end

  desc "Update files. Skip existing migrations and force overwrite locales"
  task :update do
    system 'rails g tkh_store:create_or_update_migrations -s'
    system 'rails g tkh_store:create_or_update_locales -f'
  end
end
