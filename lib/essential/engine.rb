module Essential
  class Engine < ::Rails::Engine
    isolate_namespace Essential

    initializer "Essential add to autoload", before: :set_autoload_paths do |app|
      app.config.autoload_paths += %W(#{app.config.root}/app/presenters #{app.config.root}/lib/essential)
      app.config.autoload_paths += %W(#{app.config.root}/app/forms #{app.config.root}/app/models/permissions #{app.config.root}/lib)
      app.config.autoload_paths += Dir["#{app.config.root}/app/forms/*"].find_all { |f| File.stat(f).directory?  }
      app.config.autoload_paths += Dir["#{app.config.root}/app/forms/*/*"].find_all { |f| File.stat(f).directory?  }
      app.config.assets.paths << Rails.root.join('app', 'assets', 'files')
      app.config.assets.paths << Rails.root.join('app', 'assets', 'bower_components')
      app.config.assets.precompile = [
        /application.(css|js|less|sass|scss|coffee)$/
      ]
    end

    initializer "Essential add to config", group: :test do |app|
      app.config.middleware.use(Essential::DiagnosticMiddleware)
    end

    initializer "Essential View Helpers" do
      ActiveSupport.on_load(:action_view) do
        include Essential::Helper::Common
        include Essential::Helper::Ui
      end
    end

    initializer "Add Essential Helpers To Controller" do
      ActiveSupport.on_load(:action_controller) do
        helper Essential::Engine.helpers
        include Apotomo::Rails::ControllerMethods
      end
    end

    initializer "essential.unrestricted_attributes" do
      ActiveRecord::Base.send :include, Essential::UnrestrictedAttributes
    end
  end
end
