# on tree.rb, makes words false and counter returns correct number of words

def delete_words(word)
  index = 0
  converted_word = convert_word_to_array(word)
  final_index = converted_word.length # - 1
  unpopulate_children(@root, converted_word, index, final_index)
end

def unpopulate_children(node, converted_word, index, final_index)
  letter = converted_word[index]
  delete_children(node, letter, converted_word, index, final_index)
end

def delete_children(node, letter, converted_word, index, final_index)
  # Add conditional to account for word already being present to prevent
  # counter from being increased
  if node.word == false && index < final_index
    index += 1
    unpopulate_children(node.get_child(letter), converted_word, index, final_index)
  elsif node.word == true && index == final_index
      node.delete_word
    return @number_of_words -= 1
  end
end

# on node.rb
def delete_word
  @word = false
end

# on tree_test.rb
def test_words_can_be_deleted
  @tree.insert("pizza")
  assert_equal 1, @tree.count
  @tree.delete_words("pizza")
  assert_equal 0, @tree.count
end

#refactored version

def delete_words(word)
  index = 0
  converted_word = convert_word_to_array(word)
  final_index = converted_word.length # -
  start_node = @root.get_child(converted_word[0])
  delete_children(start_node, converted_word, final_index)
end

def delete_children(node, converted_word, final_index, letter = "", index = 0)
  letter = converted_word[index]
  if node.word == false && index < final_index
    index += 1
    delete_children(node.get_child(letter), converted_word, final_index, letter = "", index = 0)
  elsif node.word == true && index == final_index
      node.delete_word
    return @number_of_words -= 1
  end
end
