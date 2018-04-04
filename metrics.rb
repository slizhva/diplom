#!/usr/bin/ruby -w

# Metrics class
class Metrics

  # get lexemes from file
  #
  # @param file_content       string
  # @param regular_expression string
  # @return array
  def file_lexemes(file_content, regular_expression)
    file_content.scan(regular_expression)
  end

  # get project lexemes by path
  #
  # @param project_path       string
  # @param regular_expression string
  # @return array
  def project_lexemes(project_path, regular_expression)
    files_path =  Dir.glob(project_path + '/**/*').select{ |file_path| File.file? file_path }
    project_lexemes = Array[]
    files_path.each { |file_path| project_lexemes += self.file_lexemes(file_path, regular_expression)}
    project_lexemes
  end

  # get project count lines
  #
  # @param file_content string
  # @return int
  def file_count_lines(file_content)
    file_content.scan(/\S*\s*\n/).count
  end

  # get amount of onelene comments in file
  #
  # @param file_content string
  # @return int
  def amount_of_oneline_comments(file_content, start_tag, end_tag)
    comments = file_content.scan(/#{start_tag}.*#{end_tag}/)
    require 'json'
    comments.to_json.length.to_f / file_content.to_json.length * 100
  end

end