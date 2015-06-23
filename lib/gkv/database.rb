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
      clean_room = Gkv::DbFunctions::BlankSlate.new
      str_val = Gkv::GitFunctions.cat_file($items.fetch(key).last)
      proc do
        clean_room.instance_eval do
          binding
        end.eval("#{str_val}")
      end.call
    end

    def get_version(version, key)
      hash = $items[key][version.to_i - 1]
      clean_room = Gkv::DbFunctions::BlankSlate.new
      str_val = Gkv::GitFunctions.cat_file(hash)
      proc do
        clean_room.instance_eval do
          binding
        end.eval("#{str_val}")
      end.call
    end

    def all
      $items.keys.map { |key|
        hash = $items[key].last
        str_val = Gkv::GitFunctions.cat_file(hash)
        clean_room = Gkv::DbFunctions::BlankSlate.new
        value = proc do
          clean_room.instance_eval do
            binding
          end.eval("#{str_val}")
        end.call
        { "#{key}": value }
      }
    end
  end
end
