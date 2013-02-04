module Exp
  class AST
    # To mixin onto visitable classes
    module Visitable
      def accept(visitor)
        visitor.visit(self)
      end
    end

    module Visitors
      # the base visitors
      class Visitor
        # Handles visitor's double dispatch by looking up
        # for a visitor's method that matches the visited node's type prefixed by 'visit_'.
        # If one is not found at the node's class, lookup will be made at's it's
        #ancestor and so on.
        def visit(node)
          method = catch(:method) do
            node.class.ancestors.each do |ancestor|
              throw :method, visitor_method(ancestor).to_sym if self.respond_to?(visitor_method(ancestor))
            end
            nil
          end
          self.__send__(method, node) unless method.nil?
        end

        private
        def visitor_method(node_class)
          "visit_#{underscore(node_class.name)}"
        end

        def underscore(class_name)
          class_name.split(/::/)
                    .last
                    .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                    .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                    .tr("-", "_")
                    .downcase
        end
      end

      #Typical binary & unary visits that may be
      #mixedin into visitor implementations
      module Navigation
        #Default visit for binary nodes
        def visit_binary_node(node)
          visit(node.left)
          visit(node.right)
        end

        #Default visit for binary nodes
        def visit_unary_node(node)
          visit(node.value) unless node.literal?
        end
      end
    end
  end
end

Dir[File.dirname(__FILE__) + '/visitors/*.rb'].each { |file| require file }