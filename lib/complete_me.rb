class CompleteMe

  attr_reader :tree

  def initialize
    @tree = Tree.new
  end

  def insert(word)
    tree.insert(word)
  end

  def count
    tree.count
  end

  def suggest(word_fragment)
    tree.suggest(word_fragment)
  end

  def populate(words)
    tree.populate(words)
  end

  def select(word_fragment, suggestion)
    tree.select(word_fragment, suggestion)
  end

  def delete(word)
    tree.delete(word)
  end
end
