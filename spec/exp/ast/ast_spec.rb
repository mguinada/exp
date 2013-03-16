describe Exp::AST do
  let(:expression) { '((7 - 2) / 0.5 * 9 ^ 2 + 1) / -99' }
  let(:ast) { Exp::Parser.new.parse(expression) }

  context 'evaluates' do
    it 'on defined mathematical operations' do
      expect(ast.eval).to eq(-8.191919191919192)
    end

    it 'empty expression evaluation returns nil' do
      expect(Exp::Parser.new.parse(nil).eval).to be_nil
      expect(Exp::Parser.new.parse('').eval).to be_nil
    end

    context 'variables' do
      let(:ast) { Exp::Parser.new.parse('((7 - 2) / 0.5 * 9 ^ 2 + x) / y') }

      it 'when binded' do
        ast.bind(x: 0.5, y: 75)
        expect(ast.eval).to eq(10.806666666666667)
      end

      it 'raises error when undefined' do
        expect { ast.eval }.to raise_error(Exp::UndefinedVariable)
      end
    end
  end

  it 'is enumerable' do
    ast = Exp::Parser.new.parse('1 * 2 / (3 + 4) - 5')

    expect(ast.each).to be_a(Enumerator)
    expect(ast.select(&:literal?).map(&:value)).to eq([1, 2, 3, 4, 5])
  end

  context 'provides string expression representations', focus: true do
    it 'infix notation' do
      expect(ast.to_infix).to eq(expression)
    end

    it 'postfix notation' do
      expect(ast.to_postfix).to eq('7 2 - 0.5 / 9 2 ^ * 1 + / 99 -')
    end
  end

  context 'provides graphical expression representations' do
    it 'graphviz' do
      require 'ruby-graphviz'
      expect(ast.grapher(format: 'graphviz')).to be_a(Exp::AST::Visitors::GraphVizGrapher)
    end

    it 'defaults to ASCII' do
      expect(ast.grapher).to be_a(Exp::AST::Visitors::AsciiGrapher)
    end
  end
end