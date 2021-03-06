require 'rails/generators/migration'

module TkhStore
  module Generators
    class CreateOrUpdateMigrationsGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "create or update store migrations"
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        puts 'creating or updating store migrations'
        migration_template "create_products.rb", "db/migrate/create_products.rb"
        migration_template "add_published_to_products.rb", "db/migrate/add_published_to_products.rb"
        migration_template "add_position_to_products.rb", "db/migrate/add_position_to_products.rb"
        migration_template "create_product_images.rb", "db/migrate/create_product_images.rb"
        migration_template "create_categories.rb", "db/migrate/create_categories.rb"
        migration_template "add_body_to_products.rb", "db/migrate/add_body_to_products.rb"
      end

    end
  end
end
