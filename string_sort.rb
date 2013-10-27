#!/usr/bin/ruby -WKu
# -*- coding: utf-8; mode: ruby-mode; -*-

class FData

  include Comparable
  attr_reader :str_num, :num, :name
  
  def initialize(_data)
    @str_num = ""
    @num = 0
    @name = _data

    on_init()
  end

  def on_init()
    ext = File.extname(@name)
    filename = File::basename( @name, suffix = ext )
    filename.scan(/\d+/).each { |m| @str_num += m }

    @num = @str_num.to_i if @str_num
  end

  def <=>(obj)
    self.num <=> obj.num
  end

  def to_s()
    "Data:\n\tnum => #{@num}\n\tstr_num => '#{@str_num}'\n"
  end
end


def main()

  files = Array.new

  if ARGV.length == 0
    # for PIPE
    line = gets
    while line
      line.strip!
      d = FData.new(line)
      files << d
      line = gets
    end
  else
    # for ARGV
    ARGV.each do |a|
      d = FData.new(a)
      files << d
    end
  end

  files.sort!

  files.each do |f|
    puts f.name
  end

end

if __FILE__ == $0
  main()
end
