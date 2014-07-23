#!/usr/bin/ruby
require 'open3'

def add_prefix()
  file_name = ARGV[0]
  i, o, e = Open3.popen3('git rev-parse --abbrev-ref HEAD')
  File.open(file_name , 'r+') do |f|
    content = f.read
    content.insert(0, "#{o.read.strip}: ")
    f.seek(0, IO::SEEK_SET)
    f.write(content)
  end
end

add_prefix
