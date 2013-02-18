require 'yaml'


class LACES::Logger
  
  attr_reader :log

  def initialize
    @log = {}
    add_meta
  end

  def [] k
    @log[:body] ||= {}
    @log[:body][k]
  end

  def []= k, v
    @log[:body] ||= {}
    @log[:body][k] = v
  end

  private
  def add_meta
    @log[:meta] = {
      :author           => settings.author,
      :version          => settings.version,
      :generation_date  => Time.now.to_s
    }
  end

end

