require "open3"

module Gkv
  module GitFunctions
    extend self

    def hash_object(data)
      Open3.popen3("git hash-object -w --stdin") do |stdin, stdout, stderr|
        stdin.write data
        stdin.close
        stdout.read.strip
      end
    end

    def cat_file(hash)
      `git cat-file -p #{hash}`
    end
  end

  module DbFunctions
    def update_items(key, value)
      if $ITEMS.keys.include? key
        history = $ITEMS[key]
        history << Gkv::GitFunctions.hash_object(value)
        $ITEMS[key] = history
      else
        $ITEMS[key] = [Gkv::GitFunctions.hash_object(value)]
      end
    end
  end
end
