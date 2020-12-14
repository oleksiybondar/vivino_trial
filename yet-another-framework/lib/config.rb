module YetAnotherFramework
  module Config
    @@wait_timeout = 5 # secconds

    def self.wait_timeout
      @@wait_timeout
    end

    def self.wait_timeout=(value)
      @@wait_timeout = value
    end
  end
end
