require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, value)
    list = bucket(key)
    if include?(key)
      list.get_link(key).val = value
    else
      list.insert(key,value)
      @count += 1
    end
    resize! if @count == num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def get_link(key)
    bucket(key).get_link(key)
  end

  def delete(key)

    @count -= 1 if include?(key)
    bucket(key).remove(key)

  end

  def each
    num_buckets.times do |i|
      list = @store[i]
      list.each do |link|
        yield(link.key, link.val)
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    old_store.each do |list|
      next if list.empty?
      list.each do |link|
        bucket(link.key).insert(link.key,link.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
