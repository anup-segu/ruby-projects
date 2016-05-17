require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)


    if @map.get(key).nil?
      eject! if count == @max
      return calc!(key)
    else
      link = @map.get_link(key)
      update_link!(link)
      return link.val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

    val = @prc.call(key)

    @store.insert(key, val)
    link = @store.last
    @map.set(key, link)

    return val
  end

  def update_link!(link)
    @store.remove(link.key)
    # byebug
    @store.insert(link.key, link.val)
  end

  def eject!
    link = @store.first
    @map.delete(link.key)
    @store.remove(link.key)
  end
end
