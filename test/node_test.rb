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

  def test_node_can_delete_word
    @node.set_word
    refute @node.delete_word
  end

  def test_node_has_no_value_for_letter_at_start
    empty_string = ""
    assert_equal empty_string, @node.letter
  end

  def test_node_can_set_letter
    assert_equal "a", @node.set_letter("a")
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

  def test_node_has_weight_of_zero_when_instantiated
    assert_equal 0, @node.weight
  end

  def test_get_child_by_key
    @node.add_child(@node2, 'a')
    assert_instance_of Node, @node.get_child('a')
  end

  def test_if_node_has_child
    refute @node.has_child?("a")
    @node.add_child(Node.new, "a")
    assert @node.has_child?("a")
  end

  def test_that_node_does_not_have_child
    assert @node.has_no_child?("a")
    @node.add_child(Node.new, "a")
    refute @node.has_no_child?("a")
  end

  def test_if_child_is_nil
    assert @node.child_nil?
    @node.add_child(Node.new, "a")
    refute @node.child_nil?
  end

  def test_that_child_is_not_nil
    refute @node.child_not_nil?
    @node.add_child(Node.new, "a")
    assert @node.child_not_nil?
  end

  def test_if_child_has_one_child?
    refute @node.has_one_child?
    @node.add_child(Node.new, "a")
    assert @node.has_one_child?
    @node.add_child(Node.new, "b")
    refute @node.has_one_child?
  end

  def test_weight_can_be_increased
    assert_equal 0, @node.weight
    @node.increase_weight
    assert_equal 1, @node.weight
    @node.increase_weight
    assert_equal 2, @node.weight
  end

  def test_child_can_be_removed
    @node.add_child(@node, "a")
    assert @node.has_one_child?
    @node.remove_child("a")
    assert @node.child_nil?
  end
end
