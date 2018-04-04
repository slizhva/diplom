#!/usr/bin/ruby -w

require './metrics'

# VHDL Metrics class
class VhdlMetrics < Metrics

  LEXEME_REGULAR_EXPRESSION = /[A-Za-z_]+[A-Za-z_\d\.]*/
  ONELINE_COMMENTS_REGULAR_EXPRESSION = /--[A-Za-z_\d\. ]*/

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

  def file_lexemes(file_path)
    super(file_path, LEXEME_REGULAR_EXPRESSION)
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
    signal_logic_vectors = file_content.scan(/(std_logic_vector\s*\(\s*\d\s*(?:downto|to)\s*\d\s*\)\s*[;:)])/)
    signal_logic_vectors.each { |signal_logic_vector|
      vector = signal_logic_vector.to_s.scan(/\d/)
      count_logic_vector_signals += (vector[0].to_i - vector[1].to_i).abs + 1
    }

    count_logic_vector_signals + count_logic_signals
  end

end