# coding: UTF-8

module Generation
  include Enumerable
  
  class << self
    def included(mod)
      class << mod
        def hoge
          2
        end
      end
    end
  end
  
  attr_reader :parents, :children
  # 後でparentsやchildren以外にできるようにする
  def initialize(*parents)
    @parents = parents
    @children = []
  end

  def each(&block)
    @children.each(&block)
  end

end

class Base
  include Generation
end













