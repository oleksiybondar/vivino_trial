
module YetAnotherFramework
  module UI
    module Named

      attr_reader :__name__
      attr_reader :__fullname__

      private

      def make_fullname
        return @__fullname__ = @__name__ unless @parent

        @__fullname__ = "#{@parent.__fullname__}.#{@__name__}"

        @__fullname__ << "[#{@options[:index]}]" if @options && @options[:index]
      end

    end
  end
end