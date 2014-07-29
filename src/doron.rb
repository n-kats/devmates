# coding : UTF-8
require 'thor'
require 'yaml'

class Doron < Thor
  
  hashes = YAML.load(File.read "./doron_user.yml")
  
  hashes.each do |cmd,h|
    desc cmd, "#{h["name"]}の設定にする"
    define_method(cmd) do
      apply_config h
    end
  end

  private
    def apply_config(h)
      h.each do |k,v|
        `git config --global user.#{k} "#{v}"`
      end
    end
end

Doron.start(ARGV)
