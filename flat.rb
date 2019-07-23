#! /usr/bin/env ruby
#
# The MIT License (MIT)
#
# Copyright (c) 2018 Tiago Lopo Da Silva
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'yaml'
require 'json'
require 'optparse'

OPTIONS = {
  separator: ' | '
}

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename __FILE__} [STDIN | file1 file2 file...]"
  opts.on( '-s', '--separator <separator>', 'Sets separator. Default is " | " ') do |value| 
    OPTIONS[:separator] = value
    ARGV.shift
  end
end.parse!

class Flatter 
  def initialize
    @stack = []
    @hash = {}
  end

  def flat(e)
    flat_rec(e)
    result = ""
    @hash.keys.each do |k|
      result << "#{k} = #{@hash[k]}\n"
    end
    result
  end

  def flat_rec (e,name="", stack=[])
    @stack=stack;
    if e.is_a? Hash and e.length > 0
      e.keys.each_with_index do |n,counter|
        @stack.push(n)
        flat_rec e[n],n, @stack
        @stack.pop if counter == e.length - 1
      end

    elsif e.is_a? Array and e.length > 0
      e.each_with_index do |n,counter|
        @stack.push("#{counter}")
        flat_rec n, "#{counter}", @stack
        @stack.pop if counter == e.length - 1
      end
    else
      @hash [ @stack.join(OPTIONS[:separator]) ]  = e.to_s
      @stack.pop
      return 
    end
  end
end


files = {}
file = []
last_file = ''

ARGF.each  do |line|
  if last_file != '' && last_file != ARGF.filename
    files[last_file] = file
    file = []
  end

  file.push line.chomp
  last_file = ARGF.filename    
end
files[last_file] = file

files.each do |k,v|
  input = v.join "\n"
  obj = YAML.load input
  flat = Flatter.new.flat obj

  if files.length == 1
    puts flat
  else
    flat.split("\n").each do |line|
      puts "#{k}: #{line}"
    end
  end
end