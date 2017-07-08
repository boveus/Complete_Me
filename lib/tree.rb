require './lib/node'
class Tree

  attr_reader :root

  def initialize
    @root = Node.new
    @number_of_words = 0
  end

  def convert_word_to_array(word)
    word.chars
  end

  def count
    @number_of_words
  end

  def populate_children(node, converted_word, position)
    last_letter = converted_word[-1]
    letter = converted_word[position]
    check_children(node, letter, last_letter, converted_word, position)
  end

  def check_children(node, letter, last_letter, converted_word, position)
    if node.has_no_child?(letter) && letter != last_letter
      node.add_child(Node.new, letter)
      position += 1
      populate_children(node.get_child(letter), converted_word, position)
    elsif node.has_no_child?(letter) && letter == last_letter
      node.add_child(Node.new, letter)
      node.get_child(letter).set_word
      return @number_of_words += 1
    elsif node.has_child?(letter) && letter != last_letter
      position += 1
      populate_children(node.get_child(letter), converted_word, position)
    elsif node.has_child?(letter) && letter == last_letter
      node.get_child(letter).set_word
      return @number_of_words += 1
    end
  end

  def insert(word)
    position = 0
    converted_word = convert_word_to_array(word)
    populate_children(@root, converted_word, position)
  end

  def suggest(word_fragment)
    word_fragment_array = convert_word_to_array(word_fragment)
    last_letter = word_fragment_array[-1]
    #refactor the above into methods
    find_suggest_start(@root, word_fragment_array, last_letter)

  end

  def find_suggest_start(node, word_fragment_array, last_letter, position = 0)
    #fix insert method to work like this one with the location of where letter is being generated
    letter = word_fragment_array[position]
    if node.has_child?(letter) && letter != last_letter
    position += 1
    find_suggest_start(node.get_child(letter), word_fragment_array, last_letter, position)
    elsif node.has_child?(letter) && letter == last_letter
    #method that traverses tree and returns all children to an array
      return_all_words_from_children(get_child(letter))
    else
     return []
  end

  def return_all_words_from_children(node, suggest_array = [])
    if node.word == true
      suggest_array << node.word
      
    else
    sort(node.left_child, sorted_array)
    sorted_array << node.data
    sort(node.right_child, sorted_array)
    end
    sorted_array
  end
  end

end
