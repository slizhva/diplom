#!/usr/bin/ruby -w

VHDL_LEXEME_REGULAR_EXPRESSION = /[A-Za-z_]+[A-Za-z_\d\.]*/

PROJECT_PATH = 'vhdl'

VHDL_RESERVED_WORDS = Array[
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

VHDL_CONDITIONAL_OPERATORS = Array[
  'if', 'for', 'elsif', 'while', 'until'
]

require './lexeme'
lexeme_obj = Lexeme.new
lexemes = lexeme_obj.get_project_lexemes(PROJECT_PATH, VHDL_LEXEME_REGULAR_EXPRESSION)
count_conditional_operators = 0
lexemes.each { |lexeme|
  count_conditional_operators += 1 if VHDL_CONDITIONAL_OPERATORS.include? lexeme
}

# puts lexemes
puts count_conditional_operators
