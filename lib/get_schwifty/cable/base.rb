# frozen_string_literal: true

module GetSchwifty
  module Cable
    # :nodoc
    class Base
      attr_reader :schwifty_job_id, :identifiers, :params

      def initialize(schwifty_job_id, params, identifiers)
        @schwifty_job_id = schwifty_job_id
        @identifiers = identifiers.symbolize_keys!
        @params = params
      end

      private

      def stream(*args)
        ActionCable.server.broadcast(
          schwifty_job_id,
          { 
            status: 200,
            body: GetSchwiftyController.renderer.new.render(*args).squish
          }
        )
      end

      def redirect(url)
        ActionCable.server.broadcast(
          schwifty_job_id,
          {
            status: 302,
            body: url
          }
        )
      end
    end
  end
end
