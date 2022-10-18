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

    def delete(value)
        @root = deleteRecursive(@root, value)
    end

    def deleteRecursive(root, value)
        if root.value == value
            root = nil 
            return root
        end

        if value < root.value
            root.left = deleteRecursive(root.left, value)
        elsif value > root.value
            root.right = deleteRecursive(root.right, value)
        else
            return root.right if root.left.nil?
            return root.left if root.right.nil?

            leftmost_leaf = leftmost_leaf(root.right)
            root.value = leftmost_leaf.value
            root.right = deleteRecursive(leftmost_leaf, root.right.value)
        end
        root
    end

    def leftmost_leaf(root)
        root = root.left until root.left.nil?
        root
    end

    def find(value)
        node = findRecursive(@root, value)
    end

    def findRecursive(root, value)
        return root if root.nil? || root.value == value

        value < root.value ? findRecursive(root.left, value) : findRecursive(root.right, value)
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

# tree.delete(4)
# tree.delete(7)

pretty_print(tree.root)

value_to_find = tree.find(12)&.value
puts "Find element 8: #{value_to_find}"