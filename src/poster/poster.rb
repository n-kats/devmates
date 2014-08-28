# coding: UTF-8
require 'yaml'
require 'erb'

# 投稿用
module MyBlog
  class Entry
    def initialize(file_title,title,body)
      @file_title = file_title    
      @title = title
      @body = body
    end
    
    def build
      docs = vars << (File.read "./template.erb")
      src = docs.join
      ERB.new(src).result
    end
    def fname
      Time.now.strftime("%Y-%m-%d-#{@file_title}.markdown")
    end
    def post
      file = "#{MyBlog::posts_path}/#{fname}"
      File.open(file,"w"){|f|f.puts build}

    end
    private
    def vars
      instance_variables.map do |var|
        "<% #{var} = \"#{instance_variable_get(var)}\" %>"
      end
    end

  end

  class << self
    def config
      conf = YAML.load(File.open "./blog_config.yml")
    end

    def posts_path
      config["posts_path"]
    end

    def before_action
    end
  end
end
puts "test?[y/otherwise]"
exit unless gets.chomp == "y" 

p Dir[MyBlog::posts_path + "/*"]
body =<<EOS
いちいち_postsにファイルを作成してgitなんちゃらって書くのが面倒なので，そこらへんを自動化することを目指す．
いまのところはdevmates/src/poster/poster.rb内でごにょごにょすると投稿できる．後日これは修正したい．
設定などはYAMLで書くことに．今のところ，_postsの場所だけが書いてある．pushするときのパスワードとかはgitの設定ですべきだと思うから，関わらないようにする．

commit logが被るので時刻を入れて対応したけど，工夫の余地は残る．しなくていいとは思うが．
EOS
x = MyBlog::Entry.new("post-test","自動投稿", body)
puts x.build
x.post
Dir.pwd
Dir.chdir MyBlog::posts_path
Dir.chdir '..'
p `git add ./_posts/#{x.fname}`
p `git commit -m "post #{x.fname} #{Time.now}"`
`git push origin`

