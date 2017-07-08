class Node
  attr_reader :letter,
              :children,
              :next_node,
              :word
  def initialize
    @word = nil
    # Depending on how we implement the traversal function we may not need
    # the letter attribute.  We could just retrieve the letter from the key
    # that points to the node, save it somwhere, and pass it along to the final
    # string.
    @letter = nil
    @children = {}
    @next_node = nil
  end

  def set_word(word)
    @word = word
  end

  def set_next_node(next_node)
    @next_node = next_node
  end

  def add_child(node, letter)
    @children[letter] = node
  end

  def get_child(letter)
    @children[letter]
  end
end
