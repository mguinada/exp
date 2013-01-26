describe Exp::Lexer do
  let(:lexer) { Exp::Lexer.new('(2 - 3) / 6 * x ^ 2.0 + SQRT(9)') }

  it 'progressively tokenizes a mathematical expression' do
    expected_tokens = [[:LEFT_BRACKET, '('], [:NUMBER, 2], [:SUB, '-'], [:NUMBER, 3], [:RIGHT_BRACKET, ')'],
                       [:DIV, '/'], [:NUMBER, 6],
                       [:MULTI, '*'], [:VAR, 'x'], [:POW, '^'], [:NUMBER, 2.0],
                       [:ADD, '+'], [:SQRT, 'SQRT'], [:LEFT_BRACKET, '('], [:NUMBER, 9], [:RIGHT_BRACKET, ')']]

    expected_tokens.each { |token| expect(lexer.next_token).to eq(token) }
    expect(lexer.next_token).to be_nil
  end

  it 'raises error on invalid symbols' do
    expect { Exp::Lexer.new('!').next_token }.to raise_error(Exp::LexerError)
  end

  describe '.tokenize' do
    let(:lexer) { Exp::Lexer.new('6 * x') }

    it 'fully tokenizes a mathematical expression' do
      expect(lexer.tokenize).to eq([[:NUMBER, 6], [:MULTI, '*'], [:VAR, 'x']])
    end
  end
end