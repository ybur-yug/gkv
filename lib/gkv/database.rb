$items = {}

module Gkv
  class Database
    include Gkv::DbFunctions
    attr_accessor :items

    def initialize
      `git init`
    end

    def set(key, value)
      update_items(key, value)
      key
    end

    def get(key)
      if $items.keys.include? key
        Gkv::GitFunctions.cat_file($items.fetch(key.to_s).last)
      else
        raise KeyError
      end
    end

    def get_version(version, key)
      Gkv::GitFunctions.cat_file($items[key][version.to_i - 1])
    end
  end
end
