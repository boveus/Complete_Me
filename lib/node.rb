require 'pry'
class Node
  attr_reader :children,
              :word
  def initialize
    @word = false
    @children = {}
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

  def child_not_nil?
    if @children.count < 1
      false
    else
      true
    end
  end

end
