require 'pry'
class Node
  attr_reader :children,
              :word,
              :letter,
              :weight

  def initialize
    @word = false
    @children = {}
    @letter = ''
    @weight = 0
  end

  def delete_word
    @word = false
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
    get_child(letter) != nil
  end

  def has_no_child?(letter)
    get_child(letter) == nil
  end

  def child_nil?
    @children.count < 1
  end

  def child_not_nil?
    @children.count > 0
  end

  def has_one_child?
    @children.count == 1
  end

  def increase_weight
    @weight += 1
  end

end
