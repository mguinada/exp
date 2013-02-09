describe Exp::AST do
  let(:ast) { Exp::Parser.new.parse('1 + 2 + (3 + 4)') }

  it 'is enumerable' do
    expect(ast.select(&:literal?).map(&:value)).to eq([1, 2, 3, 4])
  end

  context 'provides graphical representations' do
    it 'graphviz' do
      require 'ruby-graphviz'
      expect(ast.grapher(engine: 'graphviz')).to be_a(Exp::AST::Visitors::GraphVizGrapher)
    end

    it 'defaults to ASCII' do
      expect(ast.grapher).to be_a(Exp::AST::Visitors::AsciiGrapher)
    end
  end
end