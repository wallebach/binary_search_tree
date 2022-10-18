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
        @root = insert_recursive(@root, value)
    end

    def insert_recursive(root, value) 
        if root == nil
            root = Node.new(value) 
            return root
        end

        if value < root.value
            root.left = insert_recursive(root.left, value)
        elsif value > root.value
            root.right = insert_recursive(root.right, value)
        end

        root
    end

    def delete(value)
        @root = delete_recursive(@root, value)
    end

    def delete_recursive(root, value)
        if root.value == value
            root = nil 
            return root
        end

        if value < root.value
            root.left = delete_recursive(root.left, value)
        elsif value > root.value
            root.right = delete_recursive(root.right, value)
        else
            return root.right if root.left.nil?
            return root.left if root.right.nil?

            leftmost_leaf = leftmost_leaf(root.right)
            root.value = leftmost_leaf.value
            root.right = delete_recursive(leftmost_leaf, root.right.value)
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

    def level_order(root = @root)
        return if root.nil?

        queue = []
        queue.push(root)

        while !queue.empty? 
            current = queue.shift
            puts current.value
            
            queue.push(current.left) if !current.left.nil?
            queue.push(current.right) if !current.right.nil?
        end
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

value_to_find = 12 
puts "Find element : #{tree.find(value_to_find)&.value}"
tree.level_order