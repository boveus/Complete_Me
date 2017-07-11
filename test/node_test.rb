gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def setup
    @node = Node.new()
    @node2 = Node.new()
  end
  def test_node_class_exists
    assert_instance_of Node, @node
  end

  def test_node_has_no_children_by_default
    empty_hash = {}
    assert_equal empty_hash, @node.children
  end

  def test_node_has_no_word_by_default
    refute @node.word
  end

  def test_node_can_have_word
    assert @node.set_word
  end

  def test_node_has_no_value_for_letter_at_start
    empty_string = ""
    assert_equal empty_string, @node.letter
  end

  def test_node_can_set_letter
    node = Node.new
    assert_equal "", node.letter
    node.set_letter("a")
    assert_equal "a", node.letter
  end

  def test_node_can_add_children
    @node.add_child(@node2, 'a')
    hash_with_value = {'a' => @node2}
    assert_equal hash_with_value, @node.children
  end

  def test_retrieve_next_node_by_key_value
    @node.add_child(@node2, 'a')
    assert_instance_of Node, @node.children['a']
  end

  def test_get_child_by_key
    @node.add_child(@node2, 'a')
    assert_instance_of Node, @node.get_child('a')
  end

  def test_if_node_has_child
    node = Node.new
    refute node.has_child?("a")
    node.add_child(Node.new, "a")
    assert node.has_child?("a")
  end

  def test_that_node_does_not_have_child
    node = Node.new
    assert node.has_no_child?("a")
    node.add_child(Node.new, "a")
    refute node.has_no_child?("a")
  end

  def test_if_child_is_nil
    node = Node.new
    assert node.child_nil?
    node.add_child(Node.new, "a")
    refute node.child_nil?
  end

  def test_that_child_is_not_nil
    node = Node.new
    refute node.child_not_nil?
    node.add_child(Node.new, "a")
    assert node.child_not_nil?
  end

  def test_if_child_has_one_child?
    node = Node.new
    refute node.has_one_child?
    node.add_child(Node.new, "a")
    assert node.has_one_child?
    node.add_child(Node.new, "b")
    refute node.has_one_child?
  end
end
