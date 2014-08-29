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
研究過程の記録に写真や短い動画があるのは望ましい．

ひとまず，カメラの画像を受け取って表示することを目指した．

C#で頑張ろうと思ったがよくわからなかった．なので，いろいろ探してみたら，Processingが簡単にできるらしい．

他の選択肢を求めて，ほとんどしたことのないJavaをさわってみたけど，**JMF**やら**Webcam Capture**といったものがあることは分かったが，netbeansがよく分からず，あきらめ．

ひょっとしてHTML5ならと思ったらできるらしい．
**WebRTC**というもの．ただし，ブラウザによって上手くいかない場合があるみたい．
Firefoxはhtmlファイルを開くだけでちゃんと動くが，chromeはこれでは上手くいかず，一度サーバーを通さないといけないみたい．外部のサーバーじゃないといけないのかと思ったら，一か八かで試したらローカルのサーバーでもよかった．
sinatraでサーバーを立てて，publicフォルダに置くという方法．別にどうとでもできると思う．

昨日作った自動投稿プログラムの中身に書いていたりするから，
これをブラウザか何かからするようにしたい．
EOS
x = MyBlog::Entry.new("try-camera","ウェブカメを使おうとしてみる", body)
puts x.build
x.post
Dir.pwd
Dir.chdir MyBlog::posts_path
Dir.chdir '..'
p `git add ./_posts/#{x.fname}`
p `git commit -m "post #{x.fname} #{Time.now}"`
`git push origin`

