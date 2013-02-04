describe Exp::AST do
  let(:ast) { Exp::Parser.new.parse('1 + 2 + 3 + 4') }

  it 'is enumerable' do
    expect(ast.select(&:literal?).map(&:value)).to eq([1, 2, 3, 4])
  end
end