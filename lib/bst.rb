class BSTNode
  attr_accessor :left, :right
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
      node.left = BinarySearchTree.insert!(node.left, value)
    elsif node.value < value
      node.right = BinarySearchTree.insert!(node.right, value)
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

  end

  def self.inorder!(node)

  end

  def self.postorder!(node)

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

  end

  def self.delete!(node, value)

  end
end
