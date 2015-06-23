$items = {}

module Gkv
  class Database
    include Gkv::DbFunctions
    attr_accessor :items

    def initialize
      `git init`
    end

    def set(key, value, type='s')
      update_items(key, value, type)
      key
    end

    def get(key)
      if $items.keys.include? key
        hash = $items.fetch(key.to_s).last.first
        type = $items.fetch(key.to_s).last.last
        Gkv::GitFunctions.cat_file(hash).send("to_#{type}".to_sym)
      else
        raise KeyError
      end
    end

    def get_version(version, key)
      hash = $items[key][version.to_i - 1].first
      type = $items[key][version.to_i - 1].last
      Gkv::GitFunctions.cat_file(hash).send("to_#{type}".to_sym)
    end

    def all
      $items.keys.map { |key|
        hash = $items[key].last.first
        type = $items[key].last.last
        value = Gkv::GitFunctions.cat_file(hash).send("to_#{type}".to_sym)
        { "#{key}": value }
      }
    end
  end
end
