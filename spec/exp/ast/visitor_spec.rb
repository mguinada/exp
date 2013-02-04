describe Exp::AST::Visitors::Visitor do
  class Visitor < Exp::AST::Visitors::Visitor
    include Exp::AST::Visitors::Navigation

    attr_reader :call_stack
    def initialize; @call_stack = []; end

    def visit_unary_node(node)
      self.call_stack << :visit_unary_node if node.is_a?(Exp::AST::UnaryNode)
      super
    end

    def visit_division(node)
      self.call_stack << :visit_division if node.is_a?(Exp::AST::Division)
      visit_binary_node(node)
    end

    def visit_variable(node)
      self.call_stack << :visit_variable if node.is_a?(Exp::AST::Variable)
    end
  end

  let!(:ast)     { Exp::Parser.new.parse('2 + x / 3') }
  let!(:visitor) { Visitor.new }

  it 'implements double dispatching' do
    ast.accept(visitor)
    expect(visitor.call_stack).to eq([:visit_unary_node,
                                      :visit_division,
                                      :visit_variable,
                                      :visit_unary_node])
  end
end