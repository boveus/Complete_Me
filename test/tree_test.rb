require './lib/complete_me'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class TreeTest < Minitest::Test

  attr_reader :tree

  def setup
    @tree = Tree.new
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
end
