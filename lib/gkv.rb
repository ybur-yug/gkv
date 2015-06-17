#require "gkv/version"

module Gkv
  class Database
    attr_accessor :items

    def initialize
      `git init`
      @items = {}
    end

    def set(key, value)
      @items[key] = hash_object(value)
    end

    def get(key)
      cat_file(@items[key.to_s])
    end

    private

    def hash_object(data)
      write_tmpfile(data)
      hash = `git hash-object -w tmp.txt`.strip!
      File.delete('tmp.txt') 
      hash
    end
    
    def write_tmpfile(data)
      f = File.open("tmp.txt", "w+")
      f.write(data.to_s)
      f.close
    end

    def cat_file(hash)
      `git cat-file -p #{hash}`
    end
  end
end
