require_relative 'node.rb'

class Tree
    attr_accessor :root
    attr_accessor :data

    def initialize(data = []) 
        return if data.empty?
        @data = data.sort
        @root = build_tree(@data, 0, @data.length - 1)
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
        node = find_recursive(@root, value)
    end

    def find_recursive(root, value)
        return root if root.nil? || root.value == value

        value < root.value ? find_recursive(root.left, value) : find_recursive(root.right, value)
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

    def preorder(root = @root)
        return if root.nil?

        print "#{root.value} "
        preorder(root.left)
        preorder(root.right)
    end

    def inorder(root = @root)
        return if root.nil?

        inorder(root.left)
        print "#{root.value} "
        inorder(root.right)
    end

    def postorder(root = @root)
        return if root.nil?

        postorder(root.left)
        postorder(root.right)
        print "#{root.value} "
    end

    def depth(value, root = @root)
        return -1 if root == nil 

        distance = -1 

        if root.value == value || 
            (distance = depth(value, root.left)) >= 0 || 
            (distance = depth(value, root.right)) >= 0

            return distance + 1
        end

        distance
    end

    def height(root = @root)
        return -1 if root == nil

        height_recursive(root.value, root)
    end

    def height_recursive(value, root = @root)
        return -1 if root == nil

        left_height = height_recursive(value, root.left)
        right_height = height_recursive(value, root.right)

        max = [left_height, right_height].max + 1 

        return max if root.value == value
        max
    end

    def balanced?(root = @root)
        return true if root == nil

        left_height = 0
        right_height = 0

        left_height = height(root.left)
        right_height = height(root.right)

        if (left_height - right_height).abs <= 1 && 
            balanced?(root.left) && 
            balanced?(root.right)
        
            return true
        end

        return false
    end

    def rebalance
        nodes = inorder_array
        @root = build_tree(nodes, 0, nodes.length - 1)
    end

    def inorder_array(root = @root, array = [])
        unless root.nil? 
            inorder_array(root.left, array)
            array << root.value
            inorder_array(root.right, array)
        end
        array
    end

end


