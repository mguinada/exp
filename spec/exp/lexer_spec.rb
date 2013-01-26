describe Exp::Lexer do
  let(:lexer) { Exp::Lexer.new('(2 - 3) / 6 * x ^ 2.0 + SQRT(9)') }

  it 'progressively tokenizes mathematical expressions' do
    expect(lexer.next_token).to eq([:LEFT_BRACKET, '('])
    expect(lexer.next_token).to eq([:NUMBER, 2])
    expect(lexer.next_token).to eq([:SUB, '-'])
    expect(lexer.next_token).to eq([:NUMBER, 3])
    expect(lexer.next_token).to eq([:RIGHT_BRACKET, ')'])
    expect(lexer.next_token).to eq([:DIV, '/'])
    expect(lexer.next_token).to eq([:NUMBER, 6])
    expect(lexer.next_token).to eq([:MULTI, '*'])
    expect(lexer.next_token).to eq([:VAR, 'x'])
    expect(lexer.next_token).to eq([:POW, '^'])
    expect(lexer.next_token).to eq([:NUMBER, 2.0])
    expect(lexer.next_token).to eq([:ADD, '+'])
    expect(lexer.next_token).to eq([:SQRT, 'SQRT'])
    expect(lexer.next_token).to eq([:LEFT_BRACKET, '('])
    expect(lexer.next_token).to eq([:NUMBER, 9])
    expect(lexer.next_token).to eq([:RIGHT_BRACKET, ')'])
    expect(lexer.next_token).to be_nil
  end

  it 'raises error on invalid expressions' do
    expect { Exp::Lexer.new('0|1').tokenize }.to raise_error(Exp::LexerError)
  end

  describe '.tokenize' do
    let(:lexer) { Exp::Lexer.new('6 * x') }

    it 'fully tokenizes mathematical expressions' do
      expect(lexer.tokenize).to eq([[:NUMBER, 6], [:MULTI, '*'], [:VAR, 'x']])
    end
  end
end