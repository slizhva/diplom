#!/usr/bin/ruby -w

# Metrics class
class Metrics

  # get file count lines
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
    comments.join("").length.to_f / file_content.length * 100
  end

end