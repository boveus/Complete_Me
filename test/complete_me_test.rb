require './lib/complete_me'
require 'minitest/autorun'
require 'minitest/pride'

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
  def test_suggest_word_with_one_word_inserted_and_one_letter_string

      @completion.insert("pizza")
      assert_equal ["pizza"], @completion.suggest("p")
  end

  def test_suggest_word_with_one_word_inserted_and_three_letter_string

      @completion.insert("pizza")
      assert_equal ["pizza"], @completion.suggest("piz")
  end

  def test_suggest_word_with_three_similar_words_inserted
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      assert_equal ["hose", "host", "hostile"], @completion.suggest("ho")
  end

  def test_suggest_single_children
      @completion.insert("bracket")
      assert_equal ["bracket"], @completion.suggest("br")
      @completion.insert("hostile")
      assert_equal ["hostile"], @completion.suggest("ho")
      @completion.insert("mississippi")
      assert_equal ["mississippi"], @completion.suggest("mi")
  end


  def test_suggest_word_with_several_more_words_inserted
      @completion.insert("hose")
      @completion.insert("hostile")
      @completion.insert("host")
      @completion.insert("hostage")
      @completion.insert("hostel")
      @completion.insert("hoss")
      @completion.insert("hiss")
      # assert_equal ["hose", "host", "hostile", "hostage", "hostel", "hoss"], @completion.suggest("h")
      assert_equal ["hose", "host", "hostile", "hostage", "hostel", "hoss"], @completion.suggest("hos")
  end




end
