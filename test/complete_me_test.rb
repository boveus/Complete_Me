require './lib/complete_me'
require 'minitest/autorun'
require 'minitest/pride'

class CompleteMeTest < Minitest::Test

  def test_can_make_complete_me_objects
    completion = CompleteMe.new
    assert_instance_of CompleteMe, completion
  end
#spec does not tell us what insert method needs to return, do we want it to return number of inserts or something else
  def test_insert_one_item_returns_count
    skip
    completion = CompleteMe.new
    assert_equal 1, completion.insert("pizza")
  end

  def test_insert_three_items_with_different_first_letters_returns_count
    skip
    completion = CompleteMe.new
    completion.insert("pizza")
    completion.insert("house")
    assert_equal 3, completion.insert("wolves")
  end

  def test_insert_three_items_with_same_first_letters_returns_count
    skip
    completion = CompleteMe.new
    completion.insert("hose")
    completion.insert("hostile")
    assert_equal 3, completion.insert("host")
  end

  def test_insert_five_random_words_returns_count
    skip
    completion = CompleteMe.new
    word_collection = File.readlines("/usr/share/dict/words")#returns an array of all words in file
    word_1 = word_collection.sample.strip
    word_2 = word_collection.sample.strip
    word_3 = word_collection.sample.strip
    word_4 = word_collection.sample.strip
    word_5 = word_collection.sample.strip
    completion.insert(word_1)
    completion.insert(word_2)
    completion.insert(word_3)
    completion.insert(word_4)
    assert_equal 5, completion.insert(word_5)
  end

  def test_can_return_number_of_words_inserted
    completion = CompleteMe.new
    completion.insert("hose")
    completion.insert("hostile")
    completion.insert("host")
    assert_equal 3, completion.count
  end
#how many suggest tests do we want to do?
  def test_suggest_word_with_one_word_inserted_and_one_letter_string
      skip
      completion = CompleteMe.new
      completion.insert("pizza")
      assert_equal ["pizza"], completion.suggest("p")
  end

  def test_suggest_word_with_one_word_inserted_and_three_letter_string
      skip
      completion = CompleteMe.new
      completion.insert("pizza")
      assert_equal ["pizza"], completion.suggest("piz")
  end

  def test_suggest_word_with_three_similar_words_inserted
      skip
      completion = CompleteMe.new
      completion.insert("hose")
      completion.insert("hostile")
      completion.insert("host")
      assert_equal ["hose", "host", "hostile"], completion.suggest("ho")
  end


end
