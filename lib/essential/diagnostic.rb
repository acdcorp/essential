module Essential
  class DiagnosticMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      unless ENV['PRY_RESCUE']
        begin
          return @app.call(env)
        rescue StandardError => e
          trace = e.backtrace.select{ |l|l.start_with?(Rails.root.to_s) }

          msg = {
            class: e.class,
            message: e.message,
            trace: trace
          }

          ap msg
        end
      else
        Pry.rescue do
          return @app.call(env)
        end
      end
    end
  end
end
