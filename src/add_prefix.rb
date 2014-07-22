require 'open3'

def add_prefix()
  file_name = ARGV[0]
  content = ''
  File.open(file_name , 'r') do |f|
    content = f.read
  end
  i, o, e = Open3.popen3('git rev-parse --abbrev-ref HEAD')
  File.open(file_name , 'w') do |f|
    content.insert(0, "#{o.read.strip}: ")
    f.write(content)
  end
end

add_prefix
