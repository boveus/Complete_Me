require './lib/complete_me'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TreeTest < Minitest::Test

  attr_reader :tree

  def setup
    @tree = Tree.new
  end

  def test_tree_class_exists
    assert_instance_of Tree, @tree
  end

  def test_words_can_be_deleted
    @tree.insert("pizza")
    assert_equal 1, @tree.count
    @tree.delete_words("pizza")
    assert_equal 0, @tree.count
  end

  def test_tree_has_no_words_on_instantiation
    assert_equal 0, @tree.number_of_words
  end

  def test_insert_one_item_returns_count
    @tree.insert("pizza")
    assert_equal 1, @tree.count
  end

  def test_insert_three_items_with_different_first_letters_returns_count

    @tree.insert("pizza")
    @tree.insert("house")
    @tree.insert("wolves")
    assert_equal 3, @tree.count
  end

  def test_insert_three_items_with_same_first_letters_returns_count

    @tree.insert("hose")
    @tree.insert("hostile")
    @tree.insert("host")
    assert_equal 3, @tree.count
  end

  def test_insert_five_random_words_returns_count
    word_collection = File.readlines("/usr/share/dict/words")#returns an array of all words in file
    5.times do
      @tree.insert(word_collection.sample.strip)
    end
    assert_equal 5, @tree.count
  end

  def test_word_can_be_turned_into_array
    assert_equal ["h", "e", "l", "l", "o"], @tree.convert_word_to_array("hello")
  end

  def test_that_weight_can_be_increased
    @tree.insert("pizza")
    @tree.insert("pizzeria")
    @tree.root.children['p'].increase_weight
    assert_equal 1, @tree.root.children['p'].weight
  end

  def test_words_can_be_deleted
    @tree.insert("pizza")
    assert_equal 1, @tree.count
    @tree.delete_words("pizza")
    assert_equal 0, @tree.count
  end

  def test_other_words_can_be_deleted
    @tree.insert("pizza")
    @tree.insert("pizzeria")
    @tree.delete_words("pizza")
    assert_equal 1, @tree.count
  end

  def test_if_more_than_one_word_can_be_delete
    @tree.insert("hose")
    @tree.insert("hostile")
    @tree.insert("host")
    @tree.insert("hostage")
    @tree.insert("hostel")
    @tree.insert("hoss")
    @tree.insert("hiss")
    @tree.delete_words("host")
    @tree.delete_words("hostel")
    assert_equal 5, @tree.count
    assert_equal ["hose", "hoss", "hostage", "hostile"], @tree.suggest("ho")

  end

end
