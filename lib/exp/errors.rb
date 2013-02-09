module Exp
  class Error < StandardError; end
  class LexerError < Error; end
  class UndefinedVariable < Error; end
end