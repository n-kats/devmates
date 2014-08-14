# coding: UTF-8


# readme
# タスク指向文章
#
# 少人数向け(結果的に)
#

# Component
# 大切な塊
# これをやりとりする
class Document
  def initialize
    # 作者 User or Group
    @author = nil
    @message = ""
    @references = []
    @body = ""

  end

  def refer(obj)
    @references << obj unless @references.include? obj
  end

  def forget(obj)
    @references.delete obj
  end
end

class Statement < Document
  def initialize
    super
    @body = ""
  end
end


# Composite
# Statement made of an array of Statement
class Argument < Document
  include Enumerable
  def initialize
    super
    @statements = []
  end

  def each(&block)
    @statements.each(&block)
  end
end

# Argumentの集まり
# + Userの集まり
class Space < Document
  include Enumerable
  def initialize
    super
    @arguments = []
    @items = []
    @users = Group.new
  end

  def invite(user)
    @users << user unless @users.include? user
  end

  def discourage(user)
    @users.delete user
  end

  def setup(item)
    @items << item unless @items.include? item
  end

  def reject(item)
    @items.delete item
  end

  def each(&block)
    @arguments.each(&block)
  end
end

# UserやItemの抽象クラス
class Sprite
  
  def initialize
    @name = nil
    @cd = nil
  end

  def output(str, doc=@cd)

  end

end

# UserやSpaceが所有
# 他プログラムやテキスト
class Item < Sprite
  
  def apply_to(target)
    target.setup self
  end
end

# 人
class User < Sprite
  
  def initialize
    super
    # 現在地
    @cd = nil
    @items = []
    @url
  end

  def equip(item)
    @items << item unless @items.include? item
  end

  def join(target)
    target.invite self
  end

end

# 人複数
class Group < User
  include Enumerable
  def initialize
    super
    @members = []
  end

  def invite(user)
    @members << user
  end

  def each(&block)
    @members.each(&block)
  end
end

# ネットワーク部分
class Air < Item
  @server
end

#----------------------------
#----------------------------

class Room < Space
end

class Board < Space
end

# やりすぎ
class Chalk < Item
end

class Textbook < Item
end

# 他プログラムを呼び出す
class Program < Item
end

class Task < Statement
  
  def initialize
    @text = ""
    @status = ""
  end

  # 転送
  def transport
  end

  def present
    puts @text
  end
end

class Definition < Statement
end

