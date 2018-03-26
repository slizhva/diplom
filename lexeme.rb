#!/usr/bin/ruby -w

# Lexeme class
class Lexeme

  # get lexemes from file
  #
  # @param file_path          string
  # @param regular_expression string
  # return array
  def get_file_lexemes(file_path, regular_expression)
    file_content = File.read(file_path)
    file_content.scan(regular_expression)
  end

  # get project lexemes by path
  #
  # @param project_path       string
  # @param regular_expression string
  # return array
  def get_project_lexemes(project_path, regular_expression)
    files_path =  Dir.glob(project_path + '/**/*').select{ |file_path| File.file? file_path }
    project_lexemes = Array[]
    files_path.each { |file_path|
      project_lexemes += self.get_file_lexemes(file_path, regular_expression)
    }
    project_lexemes
  end

end