class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value

  def initialize(value)
    @value = value
  end

end
require 'byebug'
class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    BinarySearchTree.insert!(@root, value)
  end

  def find(value)

  end

  def inorder

  end

  def postorder

  end

  def preorder

  end

  def height

  end

  def min

  end

  def max

  end

  def delete(value)

  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node == nil
    if node.value >= value
      child = BinarySearchTree.insert!(node.left, value)
      child.parent = node
      node.left = child
    elsif node.value < value
      child = BinarySearchTree.insert!(node.right, value)
      child.parent = node
      node.right = child
    end

    node
  end

  def self.find!(node, value)
    return nil if node.nil?
    return node if node.value == value
    check_left = BinarySearchTree.find!(node.left, value)
    return (check_left ? check_left : BinarySearchTree.find!(node.right, value))
  end

  def self.preorder!(node)
    return if node.nil?
    left = BinarySearchTree.inorder!(node.left)
    right = BinarySearchTree.inorder!(node.right)
    [node.value] + left  + right
  end

  def self.inorder!(node)
    return [] if node.nil?
    left = BinarySearchTree.inorder!(node.left)
    right = BinarySearchTree.inorder!(node.right)
    left + [node.value] + right
  end

  def self.postorder!(node)
    return [] if node.nil?
    left = BinarySearchTree.inorder!(node.left)
    right = BinarySearchTree.inorder!(node.right)
    left + right + [node.value]
  end

  def self.height!(node)
    return -1 if node.nil?
    left_height = BinarySearchTree.height!(node.left)
    right_height = BinarySearchTree.height!(node.right)
    1 + [left_height, right_height].max
  end

  def self.max(node)
    while node.right
      node = node.right
    end

    node
  end

  def self.min(node)
    while node.left
      node = node.left
    end

    node
  end

  def self.delete_min!(node)
    return if node.nil?
    min_node = BinarySearchTree.min(node)
    return if  node == min_node
    # debugger
    min_node.parent.left = min_node.right
    min_node.right.parent = min_node.parent
    min_node
  end

  def self.delete!(node, value)
    return if node.nil?
    d_node = BinarySearchTree.find!(node, value)

    return if node.nil?
    parent = d_node.parent
    if d_node.left && d_node.right

    elsif d_node.left || d_node.right
      child = d_node.left
      if parent.left.value == d_node.value
        BinarySearchTree.reassing(parent, d_node.right, 'left')
      parent.right = nil if parent.right.value == d_node.value
    else
      return nil
    end
  end

  def self.reassing(parent, new_child, side)
    new_child.parent = parent
    side == 'left' ? parent.left = new_child : parent.right = new_child
  end
end
