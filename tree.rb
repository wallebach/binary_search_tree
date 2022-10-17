require_relative 'node.rb'

class Tree
    attr_accessor :root

    def initialize(data = []) 
        return if data.empty?
        @root = build_tree(data, 0, data.length - 1)
    end

    def build_tree(array, array_start, array_end)
        if array_start > array_end
            return nil
        end
        
        mid = (array_start + array_end) / 2
        node = Node.new(array[mid])

        node.left = build_tree(array, array_start, mid - 1)
        node.right = build_tree(array, mid + 1, array_end)

        node
    end

    def insert(value)
        @root = insertRecursive(@root, value)
    end

    def insertRecursive(root, value) 
        if root == nil
            root = Node.new(value) 
            return root
        end

        if value < root.value
            root.left = insertRecursive(root.left, value)
        elsif value > root.value
            root.right = insertRecursive(root.right, value)
        end

        root
    end
end

def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

data = [1,2,3,4,5,6,7,15,16]

tree = Tree.new(data)

tree.insert(12)
tree.insert(8)
tree.insert(9)

pretty_print(tree.root)