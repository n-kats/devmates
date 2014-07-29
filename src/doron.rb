# coding : UTF-8
require 'thor'

class Doron < Thor
  
  desc 'hello', 'say hello message'
  def hello
    puts '‚¿‚Á‚·'
  end
end
=begin
puts Thor.methods.select{|x|!(Object.methods.include?x)}
puts "--"
puts Thor.instance_methods.select{|x|!(Object.instance_methods.include?x)}
puts "--"
=end
Doron.start(ARGV)
