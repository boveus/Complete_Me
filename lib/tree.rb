require './lib/node'
class Tree

  attr_reader :root,
              :number_of_words

  def initialize
    @root = Node.new
    @number_of_words = 0
  end

  def count
    @number_of_words
  end

  def insert(word)
    converted_word = convert_word_to_array(word)
    check_children(converted_word)
  end

  def check_children(converted_word, node = @root, index = 0, final_index = 0)
    letter = converted_word[index]
    final_index = converted_word.length
    if node.has_no_child?(letter) && index < final_index
      node.add_child(Node.new, letter)
      index += 1
      check_children(converted_word, node.get_child(letter), index, final_index)
    elsif node.has_no_child?(letter) && index == final_index
        node.set_word
      return @number_of_words += 1
    elsif node.has_child?(letter) && index < final_index
      index += 1
      check_children(converted_word, node.get_child(letter), index, final_index)
    elsif node.has_child?(letter) && index == final_index
      node.set_word
      return @number_of_words += 1
    end
  end

  def convert_word_to_array(word)
    word.chars
  end



  def suggest(word_fragment)
    word_fragment_array = convert_word_to_array(word_fragment)
    word_array, word_weight_array = find_suggest_start(@root, word_fragment_array)
    return_weighted_array(word_array, word_weight_array)
  end

  def find_suggest_start(node, word_fragment_array, index = 0, word = '')
    final_index = word_fragment_array.length
    current_letter = word_fragment_array[index]
    if node.has_child?(current_letter) && index < final_index
      index += 1
      word += current_letter
      next_node = node.get_child(current_letter)
      find_suggest_start(next_node, word_fragment_array, index, word)
    elsif index == final_index
      word.chop!
      walk_trie(node, word)
    end
  end

  def walk_trie(node, word = '' , word_array = [], prefix = '', word_weight_array = [])
    if node.word && node.children.count > 0
      prefix = word
      word += node.letter
      word_array << prefix + node.letter
      word_weight_array << node.weight
      node.children.each_value do |child_node|
        walk_trie(child_node, word, word_array, prefix, word_weight_array)
      end
    elsif node.word && node.children.count == 0
      prefix = word
      word += node.letter
      word_array << prefix + node.letter
      word_weight_array << node.weight
    else
      word += node.letter
      node.children.each_value do |child_node|
        walk_trie(child_node, word, word_array, prefix, word_weight_array)
      end
    end
    return word_array, word_weight_array

  end

  def return_weighted_array(word_array, word_weight_array)
    weight_hash = create_weight_hash(word_array, word_weight_array)
    sort_weight_hash(weight_hash)
  end

  def create_weight_hash(key, values)
    Hash[key.zip(values)]
  end

  def sort_weight_hash(weight_hash, final_word_array = [], word_array = [], weighted_word_array = [])
    hash_original = weight_hash.select { |word, weight| weight < 1}
    hash_copy = weight_hash.select { |word, weight| weight > 0}
    sorted_hash_copy = hash_copy.sort_by { |word, weight| weight}.reverse!
    sorted_hash_copy.each do |word|
      weighted_word_array << word[0]
    end
    hash_original.each_key do |word|
      word_array << word
    end
    weighted_word_array + word_array.sort
  end

  def retrieve_single_child(node)
    letter = node.children.keys.join
    node.children[letter]
  end

  def populate(words)
    word_array = words.split("\n")
    word_array.each do |word|
      insert(word)
    end
  end

  def select(word_fragment, suggestion)
    suggestion_array = convert_word_to_array(suggestion)
    increase_weight(suggestion_array)
  end

  def increase_weight(suggestion_array, node = @root, index = 0)
    final_index = suggestion_array.length - 1
    letter = suggestion_array[index]
    if node.has_child?(letter) && index < final_index
      index += 1
      increase_weight(suggestion_array, node.get_child(letter), index)
    else
      node.get_child(letter).increase_weight
    end
  end

  def delete(word)
    index = 0
    converted_word = convert_word_to_array(word)
    final_index = converted_word.length # - 1
    delete_children(@root, converted_word, index, final_index)
  end

  def delete_children(node, converted_word, index, final_index, last_letter = "")
    letter = converted_word[index]
    if node.word == false && index < final_index
      index += 1
      delete_children(node.get_child(letter), converted_word, index, final_index)
    elsif node.word == true && index == final_index && node.child_not_nil?
        node.delete_word
        return @number_of_words -= 1
    elsif index == final_index && node.child_nil?
      last_letter = converted_word.pop
      kill_children(@root, converted_word, 0)
      @number_of_words -= 1
    end
  end

  def kill_children(node, converted_word, index)
      final_index = converted_word.length - 1
      letter = converted_word[index]
      if index < final_index
        index += 1
        next_node = node.get_child(letter)
        kill_children(next_node, converted_word, index)
      elsif index == final_index && node.children.length < 1
        node.remove_child(letter)
        converted_word.pop
        kill_children(node.get_child(letter), converted_word, index)
      elsif index = final_index && node.children.length > 0
        node.remove_child(letter)
      end
  end
end
