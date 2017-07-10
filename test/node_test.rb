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
end
