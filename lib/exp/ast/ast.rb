require 'exp/ast/visitors'

module Exp
  # The abstract sytanx tree
  class AST
    include Enumerable
    extend Forwardable

    attr_reader :root, :context

    def_delegators :root, :accept, :each

    def initialize(root = nil)
      @root = root
      @context = Context.new
    end

    def bind(hash = {})
      @context.bind(hash)
      self
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

    def to_infix
      notation(:infix)
    end

    def to_postfix
      notation(:postfix)
    end

    private
    def notation(notation)
      accept(v = Visitors::Notation.new(notation))
      v.to_s
    end
  end
end