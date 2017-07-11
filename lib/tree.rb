require './lib/node'
class Tree

  attr_reader :root

  def initialize
    @root = Node.new
    @number_of_words = 0
  end

  def count
    @number_of_words
  end

  def populate_children(node, converted_word, index, final_index)
    letter = converted_word[index]
    check_children(node, letter, converted_word, index, final_index)
  end

  def check_children(node, letter, converted_word, index, final_index)
    # Add conditional to account for word already being present to prevent
    # counter from being increased
    if node.has_no_child?(letter) && index < final_index
      node.add_child(Node.new, letter)
      index += 1
      populate_children(node.get_child(letter), converted_word, index, final_index)
    elsif node.has_no_child?(letter) && index == final_index
      node.set_word
      return @number_of_words += 1
    elsif node.has_child?(letter) && index < final_index
      index += 1
      populate_children(node.get_child(letter), converted_word, index, final_index)
    elsif node.has_child?(letter) && index == final_index
      node.get_child(letter).set_word
      return @number_of_words += 1
    end
  end

  def convert_word_to_array(word)
    word.chars
  end

  def insert(word)
    index = 0
    converted_word = convert_word_to_array(word)
    final_index = converted_word.length # - 1
    populate_children(@root, converted_word, index, final_index)
  end

  def suggest(word_fragment)
    word_fragment_array = convert_word_to_array(word_fragment)
    final_index = word_fragment_array.length - 1
    find_suggest_start(@root, word_fragment_array, final_index, word_fragment)
  end

  def find_suggest_start(node, word_fragment_array, final_index, word_fragment, index = 0)
    #fix insert method to work like this one with the location of where letter is being generated
    letter = word_fragment_array[index]
    if node.has_child?(letter) && index < final_index
      index += 1
      find_suggest_start(node.get_child(letter), word_fragment_array, final_index, word_fragment, index)
    elsif index == final_index
      # word_fragment.chop!

      walk_trie(node)
    end
  end

  def walk_trie(node, prefix = '', word_array = [], word = '')
    if node.word
      prefix = word
      word += node.letter
      word_array << prefix + node.letter
      node.children.each_value do |child_node|
        walk_trie(child_node, prefix, word_array, word)
      end
    else
      word << node.letter
      node.children.each_value do |child_node|
        walk_trie(child_node, prefix, word_array, word)
      end
    word_array
    end
  end

  def retrieve_single_child(node)
    letter = node.children.keys.join
    node.children[letter]
  end

end
