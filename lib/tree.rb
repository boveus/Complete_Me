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

end
