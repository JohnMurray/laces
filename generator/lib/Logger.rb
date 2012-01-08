require 'yaml'


module INFLUENTIAL

  class Logger
    
    def initialize
      @log = {}
      add_meta
    end

    def save
    end


    private
    def add_meta
      @log[:meta] = {
        :author => 'John Murray <me AT johnmurray.io>',
        :version => '0.0.1'
      }
    end

  end

end
