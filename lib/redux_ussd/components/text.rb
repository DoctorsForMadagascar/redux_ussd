# frozen_string_literal: true

require 'redux_ussd/components/base'

module ReduxUssd
  module Components
    # Component to simple text rendering
    class Text < Base
      def initialize(options = {})
        super(options)
        @text = options[:text]
      end

      attr_reader :text

      def render
        @text
      end
    end
  end
end
