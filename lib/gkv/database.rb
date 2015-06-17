$items = {}
module Gkv
  class Database
    attr_accessor :items

    def initialize
      `git init`
    end

    def set(key, value)
      if Gkv::DbFunctions.key_present?(key, $items)
        updated_history = $items[key]
        updated_history << Gkv::GitFunctions.hash_object(value.to_s)
        $items[key] = updated_history
      else
        $items[key] = [Gkv::GitFunctions.hash_object(value.to_s)]
      end
    end

    def get(key)
      Gkv::GitFunctions.cat_file($items[key.to_s].last)
    end

    def get_version(version, key)
      Gkv::GitFunctions.cat_file($items[key][version.to_i - 1])
    end
  end
end
