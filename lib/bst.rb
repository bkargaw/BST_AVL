require 'byebug'

class BSTNode
  attr_accessor :left, :right, :parent
  attr_reader :value

  def initialize(value)
    @value = value
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    @root = BinarySearchTree.insert!(@root, value)
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
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
    [node.value] + left + right
  end

  def self.inorder!(node)
    return [] if node.nil?
    left = BinarySearchTree.inorder!(node.left)
    right = BinarySearchTree.inorder!(node.right)
    left + [node.value] + right
  end

  def self.postorder!(node)
    return [] if node.nil?
    left = BinarySearchTree.postorder!(node.left)
    right = BinarySearchTree.postorder!(node.right)
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
    min_node.parent.left = min_node.right if min_node.parent
    min_node.right.parent = min_node.parent if min_node.right
    min_node
  end

  def self.delete!(node, value)
    return if node.nil?
    d_node = BinarySearchTree.find!(node, value)

    return if node.nil?
    parent = d_node.parent
    if parent && parent.left && parent.left.value == d_node.value
      side = 'left'
    elsif parent && parent.right && parent.right.value == d_node.value
      side = 'right'
    end

    if d_node.left && d_node.right
      # first : use delete_min! to delete and get the min node from the
      #         right sub tree
      # second : delete the current node
      # third : replace the current node with the min node
      min_node = BinarySearchTree.delete_min!(d_node.right)
      min_node = d_node.right if min_node.nil?
      BinarySearchTree.reassing(parent, min_node, side) if parent
      min_node.left = d_node.left
    elsif d_node.left
      BinarySearchTree.reassing(parent, d_node.left, side) if parent
    elsif d_node.right
      BinarySearchTree.reassing(parent, d_node.right, side) if parent
    else
      side ? BinarySearchTree.reassing(parent, nil, side) : nil
    end
  end

  def self.reassing(parent, new_child, side)
    new_child.parent = parent if new_child
    side == 'left' ? parent.left = new_child : parent.right = new_child
  end
end
