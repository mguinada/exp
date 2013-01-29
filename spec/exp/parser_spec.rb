describe Exp::Parser do
  let(:parser) { Exp::Parser.new }

  context 'parses expressions into an abstract syntax trees' do
    context 'numbers' do
      it 'positive' do
        expect(parser.parse('1')).to eq(Exp::AST::Trunk.new([Exp::AST::Number.new(1)]))
      end

      it 'negative' do
        expect(parser.parse('-1')).to eq(Exp::AST::Trunk.new([Exp::AST::Number.new(-1)]))
      end
    end

    context 'variables' do
      it 'single letter' do
        expect(parser.parse('x')).to eq(Exp::AST::Trunk.new([Exp::AST::Variable.new('x')]))
      end

      it 'raises error on multiple letter variables' do
        expect { parser.parse('xy') }.to raise_error(Racc::ParseError)
      end
    end

    it 'addition' do
      expect(parser.parse('2 + 3')).to eq(Exp::AST::Trunk.new([Exp::AST::Addition.new(
                                                                 Exp::AST::Number.new(2),
                                                                 Exp::AST::Number.new(3),
                                                              )]))
    end

    it 'subtraction' do
      expect(parser.parse('2 - 3')).to eq(Exp::AST::Trunk.new([Exp::AST::Subtraction.new(
                                                                 Exp::AST::Number.new(2),
                                                                 Exp::AST::Number.new(3)
                                                               )]))
    end

    it 'mutiplication' do
      expect(parser.parse('2 * 3')).to eq(Exp::AST::Trunk.new([Exp::AST::Multiplication.new(
                                                                 Exp::AST::Number.new(2),
                                                                 Exp::AST::Number.new(3)
                                                               )]))
    end

    it 'division' do
      expect(parser.parse('2 / 3')).to eq(Exp::AST::Trunk.new([Exp::AST::Division.new(
                                                                 Exp::AST::Number.new(2),
                                                                 Exp::AST::Number.new(3)
                                                               )]))
    end


    it 'brackets' do
      expect(parser.parse('(2 - 3)')).to eq(Exp::AST::Trunk.new([Exp::AST::Brackets.new(
                                                                  Exp::AST::Subtraction.new(
                                                                    Exp::AST::Number.new(2),
                                                                    Exp::AST::Number.new(3),
                                                                  )
                                                                )]))
    end

    it 'exponentiation' do
      expect(parser.parse('2 ^ 3')).to eq(Exp::AST::Trunk.new([Exp::AST::Exponentiation.new(
                                                                Exp::AST::Number.new(2),
                                                                Exp::AST::Number.new(3),
                                                              )]))
    end
  end
end