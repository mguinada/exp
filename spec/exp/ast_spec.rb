describe Exp::AST do
  let(:ast) { Exp::AST.new }

  it 'evaluates it self' do
    expect(ast).to respond_to(:evaluate)
  end
end