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

  def populate_children(node, converted_word, index)
    last_letter = converted_word[-1]
    letter = converted_word[index]
    check_children(node, letter, last_letter, converted_word, index)
  end

  def check_children(node, letter, last_letter, converted_word, index)
    if node.has_no_child?(letter) && index < converted_word.length
      node.add_child(Node.new, letter)
      index += 1
      populate_children(node.get_child(letter), converted_word, index)
    elsif node.has_no_child?(letter) && index = (converted_word.length + 1)
      node.add_child(Node.new, letter)
      node.get_child(letter).set_word
      return @number_of_words += 1
    elsif node.has_child?(letter) && index < converted_word.length
      index += 1
      populate_children(node.get_child(letter), converted_word, index)
    elsif node.has_child?(letter) && index = (converted_word.length + 1)
      node.get_child(letter).set_word
      return @number_of_words += 1
    end
  end

  def insert(word)
    index = 0
    converted_word = convert_word_to_array(word)
    populate_children(@root, converted_word, index)
  end

  def suggest(word_fragment)
    word_fragment_array = convert_word_to_array(word_fragment)
    last_letter = word_fragment_array[-1]
    #refactor the above into methods
    find_suggest_start(@root, word_fragment_array, last_letter)

  end

  def return_all_words_from_children(node, word_fragment_array, suggest_array = [])
# works for nodes that have a single child, but not if the node has multiple children
    if node.word == true
      #suggest_array << node.word This returns true or false, not the word
      suggest_array << word_fragment_array.join
      node.children.each do |letter, child_node|
        word_fragment_array << letter

        return_all_words_from_children(child_node, word_fragment_array, suggest_array)
      end

    else
      node.children.each do |letter, child_node|
        word_fragment_array << letter
        return_all_words_from_children(child_node, word_fragment_array, suggest_array)
      end
    end
      suggest_array
  end

  # def sort(node=@root, sorted_array = [])
  # if (node == nil)
  #   return
  # else
  # sort(node.left_child, sorted_array)
  # sorted_array << node.data
  # sort(node.right_child, sorted_array)
  # end
  # sorted_array
  # end

  def find_suggest_start(node, word_fragment_array, last_letter, index = 0)
    #fix insert method to work like this one with the location of where letter is being generated
    letter = word_fragment_array[index]
    if node.has_child?(letter) && letter != last_letter
    index += 1
    find_suggest_start(node.get_child(letter), word_fragment_array, last_letter, index)
    elsif node.has_child?(letter) && letter == last_letter
    #method that traverses tree and returns all children to an array
      return_all_words_from_children(node.get_child(letter), word_fragment_array)
    else
     return []
    end
  end





end
