require 'pry'
class Node
  attr_reader :children,
              :word,
              :letter

  def initialize
    @word = false
    @children = {}
    @letter = ''
  end

  def set_word
    @word = true
  end

  def set_letter(letter)
    @letter = letter
  end

  def add_child(node, letter)
    @children[letter] = node
    @children[letter].set_letter(letter)
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

  def child_nil?
    if @children.count < 1
      true
    else
      false
    end
  end

  def child_not_nil?
    if @children.count > 0
      true
    else
      false
    end
  end

end
