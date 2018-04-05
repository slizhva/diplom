#!/usr/bin/ruby -w


PROJECT_PATH = 'vhdl'
FILE_PATH = 'vhdl/Package_Implementation'

require './vhdl_metrics'
metric = VhdlMetrics.new

# puts metric.count_conditional_operators

# puts lexemes
# puts count_conditional_operators

require './graph'
control_graph = Graph.new
control_graph[1][2] = 3

file_content = File.read(FILE_PATH)
puts 'count lines: ' + metric.file_count_lines(file_content).to_s
puts 'amount of comments: ' + metric.amount_of_oneline_comments(file_content).to_s + ' %'
puts 'count operators: ' + metric.count_operators(file_content).to_s
puts 'count of entity components: ' + metric.count_entity_components(file_content).to_s
puts 'count of architecture components: ' + metric.count_architecture_components(file_content).to_s
puts 'count of signals: ' + metric.count_signals(file_content).to_s
puts 'count of signal assignment operators: ' + metric.signal_assignment_operators_count(file_content).to_s