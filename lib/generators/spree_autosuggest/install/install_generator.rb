module SpreeAutosuggest
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_javascripts
        append_file "vendor/assets/javascripts/spree/frontend/all.js",
                    "//= require jquery-ui/autocomplete\n//= require frontend/spree_autosuggest\n"
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require jquery-ui/autocomplete\n", before: /\*\//, verbose: true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_autosuggest'
      end

      def run_migrations
        res = ask 'Would you like to run the migrations now? [Y/n]'
        if res == '' || res.casecmp == 'y'
          run 'bundle exec rake db:migrate'
        else
          puts "Skiping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
