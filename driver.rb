require_relative 'tree.rb'

def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
end

def print_in_order(tree)
    puts "Preorder:"
    puts tree.preorder
    puts 
    
    puts "Inorder:"
    puts tree.inorder
    puts 
    
    puts "Postorder:"
    puts tree.postorder
    puts 
end

def print_balanced(tree)
    puts "Tree balanced: #{tree.balanced?}\n\n"
end

# Driver script

data = Array.new(15) { rand(1..100) }
tree = Tree.new(data)

print_balanced(tree)

print_in_order(tree)

tree.insert(200)
tree.insert(300)
tree.insert(400)

print_balanced(tree)

tree.rebalance
print_balanced(tree)
print_in_order(tree)