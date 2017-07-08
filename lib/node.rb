require 'pry'
class Node
  attr_reader :letter,
              :children,
              :next_node,
              :word
  def initialize
    @word = false
    # Depending on how we implement the traversal function we may not need
    # the letter attribute.  We could just retrieve the letter from the key
    # that points to the node, save it somwhere, and pass it along to the final
    # string.
    @children = {}
    @next_node = nil
  end

  def set_word
    @word = true
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

  def has_child?(letter)
    if get_child(letter) != nil
      true
    else
      false
    end
  end

  def has_no_child?(letter)
    if get_child(letter) == nil
      true
    else
      false
    end
  end

end
