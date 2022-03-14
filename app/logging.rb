require 'logger'

module Logging
  class << self
    # memoized logger
    def logger
      @logger ||= Logger.new("ruby_rogue.log")
    end

    def logger=(logger)
      @logger = logger
    end
  end

  # Addition
  def self.included(base)
    class << base
      def logger
        Logging.logger
      end
    end
  end

  def logger
    Logging.logger
  end
end
