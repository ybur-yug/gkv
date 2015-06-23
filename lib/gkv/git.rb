module Gkv
  module GitFunctions
    extend self

    def hash_object(data)
      write_tmpfile(data)
      hash = `git hash-object -w tmp.txt`.strip!
      File.delete('tmp.txt')
      hash
    end

    def write_tmpfile(data)
      f = File.open('tmp.txt', 'w+')
      f.write(data.to_s)
      f.close
    end

    def cat_file(hash)
      `git cat-file -p #{hash}`
    end
  end

  module DbFunctions
    def update_items(key, value, type)
      if $items.keys.include? key
        history = $items[key]
        history << [Gkv::GitFunctions.hash_object(value.to_s), type]
        $items[key] = history
      else
        $items[key] = [[Gkv::GitFunctions.hash_object(value.to_s), type]]
      end
    end
  end
end
