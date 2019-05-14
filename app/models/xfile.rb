class Xfile < ActiveRecord::Base
  has_and_belongs_to_many :groups

  require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
  require 'crack/xml' # Only XML parsing
  require 'json'
  attr_accessible :name, :content

  def self.get_properties_from_string(h)
    return self.get_properties(eval(h))
  end

  def self.get_properties(h)
    new_array = []
    if h.is_a?(Hash)
      h.each_pair do |key, val|
        if new_array.exclude?(key) and !val.is_a?(Hash) and !val.is_a?(Array) # make sure it's simple
          new_array.push(key)
        else
          new_keys = get_properties(val)
          new_keys.each do |key|
            if new_array.exclude?(key)
              new_array.push(key)
            end
          end
        end
      end
    elsif h.is_a?(Array) && h[0].is_a?(Hash)
      h.each do |hash|
        new_array = new_array + get_properties(hash)
      end
    else
      return []
    end
    return new_array
  end

end