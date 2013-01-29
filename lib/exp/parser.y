class Exp::Parser
  token NUMBER LEFT_BRACKET RIGHT_BRACKET ADD SUB MULTI DIV POW VAR

  prechigh
    nonassoc UMINUS
    left POW
    left MULTI DIV
    left ADD SUB
  preclow

  expect 3

  rule
    program: expression                               { result = Exp::AST.new([val[0]]) }
           | /* none */                               { result = Exp::AST.new([]) }

    expression: expression ADD expression             { result = Exp::AST::Addition.new(val[0], val[2]) }
              | expression SUB expression             { result = Exp::AST::Subtraction.new(val[0], val[2]) }
              | expression MULTI expression           { result = Exp::AST::Multiplication.new(val[0], val[2]) }
              | expression DIV expression             { result = Exp::AST::Division.new(val[0], val[2]) }
              | expression POW expression             { result = Exp::AST::Exponentiation.new(val[0], val[2]) }
              | LEFT_BRACKET expression RIGHT_BRACKET { result = Exp::AST::Brackets.new(val[1]) }
              | SUB NUMBER =UMINUS                    { result = Exp::AST::Number.new(-1 * val[1]) }
              | NUMBER                                { result = Exp::AST::Number.new(val[0]) }
              | VAR                                   { result = Exp::AST::Variable.new(val[0]) }
end

---- header

require 'exp/ast'

---- inner
def parse(expression, show_tokens = false)
  @tokenizer = Exp::Lexer.new(expression)
  puts @tokenizer.tokenize.inspect if show_tokens

  do_parse
end

def next_token
  @tokenizer.next_token
end