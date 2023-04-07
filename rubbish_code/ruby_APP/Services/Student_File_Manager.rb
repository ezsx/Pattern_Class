# frozen_string_literal: true

require_relative 'File_Manager'
require_relative '../Services/File_Strategies/Txt_Strategy'
require_relative '../Services/File_Strategies/Json_Strategy'
require_relative '../Services/File_Strategies/Yaml_Strategy'

class StudentFileManager
  include FileManager

  def load_data(source)
    set_strategy_for(source)
    @strategy.load_data(source)
  end

  def save_data(destination, data)
    set_strategy_for(destination)
    @strategy.save_data(destination, data)
  end

  private
  def set_strategy_for(file_path)
    case File.extname(file_path)
    when '.txt'
      @strategy = TXTFileStrategy.new
    when '.json'
      @strategy = JSONFileStrategy.new
    when '.yaml'
      @strategy = YAMLFileStrategy.new
    else
      raise "Unknown file type"
    end
  end
end