module Gkv
  class Database
    attr_accessor :items

    def initialize
      `git init`
      @items = {}
    end

    def set(key, value)
      @items[key] = Gkv::GitFunctions.hash_object(value)
    end

    def get(key)
      Gkv::GitFunctions.cat_file(@items[key.to_s])
    end
  end
end
