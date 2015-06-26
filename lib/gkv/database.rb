require 'yaml'

$ITEMS = {}

module Gkv
  class Database
    include Gkv::DbFunctions
    attr_accessor :items

    def initialize
      `git init`
    end

    def set(key, value)
      update_items(key, YAML.dump(value))
      key
    end

    def []=(key, value)
      set(key, value)
    end

    def get(key)
      if $ITEMS.keys.include? key
        YAML.load(Gkv::GitFunctions.cat_file($ITEMS[key].last))
      else
        raise KeyError
      end
    end

    def [](key)
      get(key)
    end

    def get_version(version, key)
      YAML.load(Gkv::GitFunctions.cat_file($ITEMS[key][version.to_i - 1]))
    end

    def all
      $ITEMS.keys.map { |key|
        hash = $ITEMS[key].last
        value = YAML.load(Gkv::GitFunctions.cat_file(hash))
        { "#{key}" => value }
      }
    end
  end
end
