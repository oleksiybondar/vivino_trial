
module YetAnotherFramework
  # going to contains static Framework configuration fields
  #
  module Config
    @@wait_timeout = 5 # seconds

    # wait timeout getter
    #
    # @return [Numeric] - timeout in seconds
    #
    def self.wait_timeout
      @@wait_timeout
    end

    # wait timeout setter
    #
    # @param [Numeric] value - a new timeout value
    # @return [Numeric]
    def self.wait_timeout=(value)
      @@wait_timeout = value
    end
  end
end
