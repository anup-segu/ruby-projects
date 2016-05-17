require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array

  def hash
    total_hash = 0.hash.abs.to_s + self[0].hash.abs.to_s

    self.drop(1).each_with_index do |el, idx|
      h = idx.hash.abs.to_s + el.hash.abs.to_s
      total_hash += h
    end

    total_hash.to_i.hash
  end
end

class String
  def hash
    str_array = self.chars

    str_array.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h_keys = self.keys.sort
    first_key = h_keys.first
    first_value = self[first_key]
    total_hash = first_key.hash.abs.to_s + first_value.hash.abs.to_s

    h_keys.drop(1).sort.each do |key|
      total_hash += key.hash.abs.to_s
      total_hash += self[key].hash.abs.to_s
    end

    total_hash.to_i.hash

  end
end
