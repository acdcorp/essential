module Essential
  module Presenter
    class Base
      attr_reader :object, :template

      def initialize(object, template)
        # Have to do this because Rails doesn't exist
        # when Essential::Presenter::Base is first loaded
        # idealy we should remove this.
        Essential::Presenter::Base.class_eval do
          include Rails.application.routes.url_helpers
        end

        @object = object
        @template = template
      end

      private

      def self.presents(name)
        define_method(name) do
          @object
        end
      end
    end
  end
end
