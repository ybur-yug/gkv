require 'yaml'

$ITEMS = {}

module Gkv
  class Database
    include Gkv::DbFunctions

    def initialize
      `git init`
      @git = Gkv::GitFunctions
    end

    def []=(key, value)
      set(key, value)
    end

    def set(key, value)
      update_items(key, YAML.dump(value))
      key
    end

    def [](key)
      get(key)
    end

    def get_version(version, key)
      YAML.load(@git.cat_file($ITEMS[key][version.to_i - 1]))
    end

    def all_versions(key)
      $ITEMS[key].map { |hash| YAML.load(@git.cat_file(hash)) }
    end

    def get(key)
      if $ITEMS.keys.include?(key)
        YAML.load(@git.cat_file($ITEMS[key].last))
      else
        raise KeyError
      end
    end

    def all
      $ITEMS.keys.map { |key|
        { "#{key}" => YAML.load(@git.cat_file($ITEMS[key].last)) }
      }
    end

    def save
      @git.hash_object(YAML.dump($ITEMS))
    end

    def load(hash)
      $ITEMS = YAML.load(@git.cat_file(hash))
    end
  end
end
