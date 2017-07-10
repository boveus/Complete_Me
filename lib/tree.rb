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
    find_suggest_start(@root, word_fragment_array, final_index)
  end

 # check that the path values match the fragment exactly
 # to account for fragments that contain the last letter before the end IE "loo"


  def find_suggest_start(node, word_fragment_array, final_index, index = 0)
    #fix insert method to work like this one with the location of where letter is being generated
    letter = word_fragment_array[index]
    if node.has_child?(letter) && index < final_index
      index += 1
      find_suggest_start(node.get_child(letter), word_fragment_array, final_index, index)
    elsif index == final_index
      word_fragment_array.pop
      trie_walk(node, word_fragment_array)
      #method that traverses tree and returns all children to an array
    end
  end


      # do we need this?? V
      # return_all_words_from_children(node.get_child(letter), word_fragment_array)
  #   else
  #    return  #result of tree traversal
  #   end
  # end
  #
  # add node keys we step through to a string and
  # dont return them until we reach word == true
  # find first node with children
  #
  # go to each child
  #
  # check to see if the child word == true
  #
  # check if any grandchildren exist
  #
  # break condition is word == true



  def trie_walk(node, word_fragment_array, suggested_words = [])
    node.children.each do |letter, child_node|
      if child_node.word == true && child_node.child_nil?
        word_fragment_array << letter
        # puts word_fragment_array
        suggested_words << word_fragment_array.join
      elsif node.word == true && child_node.child_not_nil?
        word_fragment_array << letter
        # puts word_fragment_array
        suggested_words << word_fragment_array.join
        trie_walk(child_node, word_fragment_array, suggested_words)
      else
        word_fragment_array << letter
        # for debugging purposes -V
        # suggested_words << word_fragment_array.join
        # puts word_fragment_array
        trie_walk(child_node, word_fragment_array, suggested_words)
      end
    end
    suggested_words
  end




  def retrieve_single_child(node)
    letter = node.children.keys.join
    node.children[letter]
  end

end




#
#   def return_all_words_from_children(node, word_fragment_array, suggest_array = [])
# # works for nodes that have a single child, but not if the node has multiple children
#     if node.children.count == 1 && retrieve_single_child(node).word == true
#       single_node_letter = node.children.keys.join
#       word_fragment_array << single_node_letter
#       suggest_array << word_fragment_array.join
#       return_all_words_from_children(node.children.values[0], word_fragment_array, suggest_array)
#
#     elsif node.children.count == 1 && node.word == false
#       node.children.each do |letter, child_node|
#         word_fragment_array << letter
#         return_all_words_from_children(child_node, word_fragment_array, suggest_array)
#       end
#
#     elsif node.children.count > 1
#       node.children.each do |letter, child_node|
#         word_fragment_array << letter
#         suggest_array = add_word_to_suggest(child_node, letter, word_fragment_array, suggest_array)
#         # word_fragment_array = cut_last_letter(child_node, letter, word_fragment_array, suggest_array)
#         return_all_words_from_children(child_node, word_fragment_array, suggest_array)
#       end
#     end
#       suggest_array
#   end
#
#   def add_word_to_suggest(node, letter, word_fragment_array, suggest_array)
#     if node.has_child?(letter) && node.children(letter).word
#       suggest_array << word_fragment_array.join
#     end
#     suggest_array
#   end
#
#   def cut_last_letter(node, letter, word_fragment_array, suggest_array)
#       # suggest_array = add_word_to_suggest(node, letter, word_fragment_array, suggest_array)
#       word_fragment_array.pop
#       word_fragment_array
#   end
