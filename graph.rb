#!/usr/bin/ruby -w

# Graph class
class Graph
  attr_reader :graph

  def initialize
    @graph = {}
  end

  def [](key)
    graph[key] ||= {}
  end

  def rows
    graph.length
  end

  alias_method :length, :rows
end