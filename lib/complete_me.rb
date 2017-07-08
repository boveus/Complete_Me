# /usr/share/dict/words
#We might need to change some of the arguments passed in to these.
require './lib/tree'

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
