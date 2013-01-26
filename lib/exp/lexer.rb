module Exp
  class Lexer
    NUMBER        = /(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?/
    LEFT_BRACKET  = /\(/
    RIGHT_BRACKET = /\)/
    SQRT          = /SQRT/
    ADD           = /[+]/
    SUB           = /[-]/
    MULTI         = /[*]/
    DIV           = /[\/]/
    POW           = /[\^]/
    VAR           = /[a-zA-Z]/

    def initialize(expression)
      @expression = expression
      set_scanner(@expression)
    end

    def tokenize
      tokens = []
      while token = next_token
        tokens << token
      end
      tokens
    ensure
      reset
    end

    def next_token
      return if @scanner.eos?

      case
      when value = @scanner.scan(NUMBER)        then [:NUMBER, begin Integer(value) rescue Float(value) end]
      when value = @scanner.scan(LEFT_BRACKET)  then [:LEFT_BRACKET, value]
      when value = @scanner.scan(RIGHT_BRACKET) then [:RIGHT_BRACKET, value]
      when value = @scanner.scan(SQRT)          then [:SQRT, value]
      when value = @scanner.scan(ADD)           then [:ADD, value]
      when value = @scanner.scan(SUB)           then [:SUB, value]
      when value = @scanner.scan(MULTI)         then [:MULTI, value]
      when value = @scanner.scan(DIV)           then [:DIV, value]
      when value = @scanner.scan(POW)           then [:POW, value]
      when value = @scanner.scan(VAR)           then [:VAR, value]
      else
        raise LexerError, "Can't scan [#{@scanner.getch}] on #{@expression}"
      end
    end

    private
    def reset
      set_scanner(@expression)
    end

    private
    def set_scanner(expression)
      @scanner = StringScanner.new(expression.delete(' '))
    end
  end
end