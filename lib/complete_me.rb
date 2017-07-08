# /usr/share/dict/words
#We might need to change some of the arguments passed in to these.
class CompleteMe

  attr_reader :tree

  def initialize
    @tree = tree
  end

  def insert(word)
    tree.insert(@tree, word)
  end

  def count
    tree.count(@tree)
  end

  def suggest(word)
    tree.suggest(@tree,word)
  end

  def populate(words)
    tree.populate(@tree, words)
  end

  def select(string, suggestion)
    tree.select(@tree, string, suggestion)#why is select a different color
  end

end
