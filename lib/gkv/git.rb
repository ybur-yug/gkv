module Gkv
  module GitFunctions
    def self.hash_object(data)
      write_tmpfile(data)
      hash = `git hash-object -w tmp.txt`.strip!
      File.delete('tmp.txt')
      hash
    end

    def self.write_tmpfile(data)
      f = File.open('tmp.txt', 'w+')
      f.write(data.to_s)
      f.close
    end

    def self.cat_file(hash)
      `git cat-file -p #{hash}`
    end
  end

  module DbFunctions
    def self.key_present?(key, items)
      items.keys.include? key
    end
  end
end
