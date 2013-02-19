require 'exp/ast/visitors'

module Exp
  # The abstract sytanx tree
  class AST
    include Enumerable
    attr_reader :root, :context

    def initialize(root = nil)
      @root = root
      @context = Context.new
    end

    def bind(hash = {})
      @context.bind(hash)
      self
    end

    def accept(visitor)
      root.accept(visitor)
    end

    def each(&block)
      root.accept(Visitors::Each.new(block))
    end

    def eval
      return nil if root.nil?
      root.eval(context)
    end

    def ==(other)
      self.class == other.class && self.root == other.root
    end

    def print(opts = {})
      grapher = grapher(opts)
      grapher.print
      grapher
    end

    def grapher(opts = {})
      visitor = case opts.fetch(:format, 'ascii').to_s
                when 'graphviz'
                  Visitors::GraphVizGrapher.new
                else
                  Visitors::AsciiGrapher.new
                end

      root.accept(visitor)
      visitor
    end
  end
end