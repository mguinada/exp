module Exp
  class AST
    module Visitors
      class GraphVizGrapher < Visitor
        attr_reader :graph

        def initialize
          raise 'Requires ruby-graphviz gem' unless defined?(GraphViz)
          @graph = GraphViz.new(:G, :type => :digraph, :ordering => :out)
        end

        def visit_binary_node(node)
          graph_binary_node(graph_node(node, node.symbol), node)
        end

        def visit_brackets(node)
          visit(node.value)
        end

        def visit_unary_node(node)
          graph_node(node, node.value.to_s)
        end

        def output(opts = {png: "graph-#{Time.now.to_s.gsub(/ |:|\+|-|0000/, '')}.png"})
          @graph.output(opts)
        end
        alias :print :output

        private
        def graph_node(node, label)
          @graph.add_nodes(node.object_id.to_s, label: label)
        end

        def graph_binary_node(graph_viz_node, node)
          @graph.add_edges(graph_viz_node, visit(node.left), dir: 'back')
          @graph.add_edges(graph_viz_node, visit(node.right), dir: 'back')
          graph_viz_node
        end
      end
    end
  end
end