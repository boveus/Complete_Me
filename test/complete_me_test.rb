require 'simplecov'
require './lib/complete_me'
require './lib/tree'
require 'minitest/autorun'
require 'minitest/pride'

SimpleCov.start


class CompleteMeTest < Minitest::Test

  attr_reader :completion
  def setup
    @completion = CompleteMe.new
  end

  def test_can_make_complete_me_objects
    assert_instance_of CompleteMe, @completion
  end

  def test_insert_one_item_returns_count
    @completion.insert("pizza")
    assert_equal 1, @completion.count
  end

  def test_insert_three_items_with_different_first_letters_returns_count
    @completion.insert("pizza")
    @completion.insert("house")
    @completion.insert("wolves")

    assert_equal 3, @completion.count
  end

  def test_insert_three_items_with_same_first_letters_returns_count
    @completion.insert("hose")
    @completion.insert("hostile")
    @completion.insert("host")
    assert_equal 3, @completion.count
  end

  def test_insert_five_random_words_returns_count
    word_collection = File.readlines("/usr/share/dict/words")#returns an array of all words in file
    5.times do
      @completion.insert(word_collection.sample.strip)
    end
    assert_equal 5, @completion.count
  end
#how many suggest tests do we want to do?

  def test_suggest_word_with_one_word_inserted_and_three_letter_string
      @completion.insert("pizza")
      assert_equal ["pizza"], @completion.suggest("pi")
  end

  def test_suggest_word_with_one_word_inserted_and_one_letter_string
      @completion.insert("pizza")
      assert_equal ["pizza"], @completion.suggest("p")
  end

  def test_suggest_single_children
      @completion.insert("bracket")
      assert_equal ["bracket"], @completion.suggest("br")
      @completion.insert("hostile")
      assert_equal ["hostile"], @completion.suggest("ho")
      @completion.insert("mississippi")
      assert_equal ["mississippi"], @completion.suggest("mi")
      @completion.insert("atlanta")
      assert_equal ["atlanta"], @completion.suggest("at")
  end

  def test_suggest_word_with_three_similar_words_inserted
      @completion.insert("host")
      @completion.insert("hose")
      @completion.insert("hostel")
      @completion.insert("hosting")

      assert_equal ["hose", "host", "hostel", "hosting"], @completion.suggest("ho")
  end

  def test_suggest_one_letter_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["hiss", "hose", "hoss", "host", "hostage", "hostel", "hostile"], @completion.suggest("h")
  end

  def test_suggest_two_letters_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["hose", "hoss", "host", "hostage", "hostel", "hostile"], @completion.suggest("ho")
  end

  def test_suggest_three_letters_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["hose", "hoss", "host", "hostage", "hostel", "hostile"], @completion.suggest("hos")
  end

  def test_suggest_four_letters_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["host", "hostage", "hostel", "hostile"],@completion.suggest("host")
  end

  def test_suggest_five_letter_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["hostile"],@completion.suggest("hosti")
  end

  def test_suggest_six_letter_with_several_related_children
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")

      assert_equal ["hostile"],@completion.suggest("hostil")
  end

  def test_suggest_word_with_ten_random_children

    word_collection = File.readlines("/usr/share/dict/words")#returns an array of all words in file
    10.times do
      @completion.insert(word_collection.sample.strip)
    end
    assert_equal 10, @completion.count
  end

  def test_populate_adds_words_to_tree
    @completion.populate("dog")
    assert_equal 1, @completion.count
  end

  def test_populate_adds_dictionary_to_tree
    dictionary = File.read("/usr/share/dict/words")
    @completion.populate(dictionary)
    assert_equal 235886, @completion.count
  end

  def test_that_suggest_returns_suggestions_by_weight
    @completion.insert('pizza')
    @completion.insert('pizzeria')
    @completion.select("piz", "pizzeria")
    assert_equal ["pizzeria", 'pizza'], completion.suggest("piz")
  end

  def test_select_for_multiple_selections
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")
      2.times { @completion.select("hos", "hoss") }
      4.times { @completion.select("hos", "hostel") }
      @completion.select("host", "host")


      assert_equal ["hostel", "hoss", "host", "hose", "hostage", "hostile"], @completion.suggest("hos")
  end


end
