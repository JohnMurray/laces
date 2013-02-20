

module Laces

  class Settings
    def initialize
      @settings = {}
    end

    def []= k, v
      @settings[k] = v
      self.class.instance_eval do
        define_method(k.to_sym) do
          begin
            @settings[k].call
          rescue NoMethodError
            @settings[k]
          end
        end
      end
    end
  end


  @settings = Settings.new

  def self.set k, v
    @settings[k] = v
  end

  def self.settings
    @settings
  end

end
