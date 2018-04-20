#!/usr/bin/ruby -w


PROJECT_PATH = 'vhdl/FPGA_Webserver/hdl'
FILE_PATH = 'vhdl/Package_Implementation'

require './vhdl_metrics'
metric = VhdlMetrics.new

puts metric.control_graph(PROJECT_PATH)

# file_content = File.read(FILE_PATH)
# puts 'count lines: ' + metric.file_count_lines(file_content).to_s
# puts 'amount of comments: ' + metric.amount_of_oneline_comments(file_content).to_s + ' %'
# puts 'count operators: ' + metric.count_operators(file_content).to_s
# puts 'count of entity components: ' + metric.count_entity_components(file_content).to_s
# puts 'count of architecture components: ' + metric.count_architecture_components(file_content).to_s
# puts 'count of signals: ' + metric.count_signals(file_content).to_s
# puts 'count of signal assignment operators: ' + metric.signal_assignment_operators_count(file_content).to_s