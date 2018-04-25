#!/usr/bin/ruby -w

PROJECT_PATH = 'vhdl/FPGA_Webserver/hdl'
FILE_PATH = 'vhdl/Package_Implementation'

require './vhdl_metrics'
metric = VhdlMetrics.new

files_path =  Dir.glob(PROJECT_PATH + '/**/*').select{ |file_path| File.file? file_path }
count_lines = 0
amount_of_comments = 0
count_operators = 0
count_entity_components = 0
count_architecture_components = 0
count_signals = 0
count_signal_operators = 0
files_path.each { |file_path|
  file_content = File.read(file_path)
  count_lines += metric.file_count_lines(file_content)
  amount_of_comments = (amount_of_comments + metric.amount_of_oneline_comments(file_content)) / 2
  count_operators += metric.count_operators(file_content)
  count_entity_components += metric.count_entity_components(file_content)
  count_architecture_components += metric.count_architecture_components(file_content)
  count_signals += metric.count_signals(file_content)
  count_signal_operators += metric.signal_assignment_operators_count(file_content)
}
graph = metric.control_graph(PROJECT_PATH)

puts 'count lines: ' + count_lines.to_s
puts 'amount of comments: ' + amount_of_comments.to_s + ' %'
puts 'count operators: ' + count_operators.to_s
puts 'count of entity components: ' + count_entity_components.to_s
puts 'count of architecture components: ' + count_architecture_components.to_s
puts 'count of signals: ' + count_signals.to_s
puts 'count of signal assignment operators: ' + count_signal_operators.to_s
puts graph