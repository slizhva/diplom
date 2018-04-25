#!/usr/bin/ruby -w

require './metrics'

# VHDL Metrics class
class VhdlMetrics < Metrics

  LEXEME_REGULAR_EXP = /[A-Za-z_]+[A-Za-z_\d.]*|<=/

  RESERVED_WORDS = Array[
    'abs',          'configuration', 'impure',   'null',      'rem',      'type',
    'access',       'constant',      'in',       'of',        'report',   'unaffected',
    'after',        'disconnect',    'inertial', 'on',        'return',   'units',
    'alias',        'downto',        'inout',    'open',      'rol',      'until',
    'all',          'else',          'is',       'or',        'ror',      'use',
    'and',          'elsif',         'label',    'others',    'select',   'variable',
    'architecture', 'end',           'library',  'out',       'severity', 'wait',
    'array',        'entity',        'linkage',  'package',   'signal',   'when',
    'assert',       'exit',          'literal',  'port',      'shared',   'while',
    'attribute',    'file',          'loop',     'postponed', 'sla',      'with',
    'begin',        'for',           'map',      'procedure', 'sll',      'xnor',
    'block',        'function',      'mod',      'process',   'sra',      'xor',
    'body',         'generate',      'nand',     'pure',      'srl',
    'buffer',       'generic',       'new',      'range',     'subtype',
    'bus',          'group',         'next',     'record',    'then',
    'case',         'guarded',       'nor',      'register',  'to',
    'component',    'if',            'not',      'reject',    'transport'
  ]

  CONDITIONAL_OPERATORS = Array[
    'if', 'for', 'elsif', 'while', 'until'
  ]

  ENTITY_COMPONENTS = Array[
    'port', 'generic'
  ]

  ARCHITECTURE_COMPONENTS= Array[
    'component'
  ]

  SIGNAL_ASSIGNMENT_OPERATORS= Array[
    '<='
  ]

  def file_lexemes(file_content)
    file_content.scan(LEXEME_REGULAR_EXP)
  end

  def count_conditional_operators(file_content)
    super(file_lexemes(file_content), CONDITIONAL_OPERATORS)
  end

  def amount_of_oneline_comments(file_content)
    super(file_content, '--', '\n')
  end

  def count_operators(file_content, operators = RESERVED_WORDS)
    lexemes = file_lexemes(file_content)
    count_operators = 0
    lexemes.each { |lexeme| count_operators += 1 if operators.include? lexeme}
    count_operators
  end

  def count_entity_components(file_content)
    count_operators(file_content, ENTITY_COMPONENTS)
  end

  def count_architecture_components(file_content)
    # division by 2 because we use word 'component' twice in begin and in end of this element
    count_operators(file_content, ARCHITECTURE_COMPONENTS) / 2
  end

  def count_signals(file_content)
    count_logic_signals = file_content.scan(/std_logic[;(\s*:=)]/).count

    count_logic_vector_signals = 0
    signal_logic_vectors = file_content.scan(
        /std_logic_vector\s*\(\s*\d\s*downto\s*\d\s*\)\s*[;:)]|std_logic_vector\s*\(\s*\d\s*to\s*\d\s*\)\s*[;:)]/
    )
    signal_logic_vectors.each { |signal_logic_vector|
      vector = signal_logic_vector.scan(/\d/)
      count_logic_vector_signals += (vector[0].to_i - vector[1].to_i).abs + 1
    }

    count_logic_vector_signals + count_logic_signals
  end

  def signal_assignment_operators_count(file_content)
    count_operators(file_content, SIGNAL_ASSIGNMENT_OPERATORS)
  end

  def control_graph(project_path)
    control_graph = []
    branch_number = 0
    files_path =  Dir.glob(project_path + '/**/*').select{ |file_path| File.file? file_path }
    files_path.each { |file_path|
      architecture = File.read(file_path).scan(/(architecture Behavioral of.*end Behavioral;)/m)[0][0]
      architecture_name = architecture.scan(/architecture Behavioral of (.*) is/)[0][0]
      components = architecture.scan(/component (.*) is/)
      if components.count === 0
        control_graph[branch_number += 1] = [architecture_name => '']
      else
        components.each {|component| control_graph[branch_number += 1] = [architecture_name => component[0]]}
      end
    }
    control_graph
  end
end