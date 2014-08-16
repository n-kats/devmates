# coding: UTF-8

require 'minitest/autorun'
require '../src/generation'

MiniTest.autorun

class TestBase < MiniTest::Test
  def setup
  end
  
  def test_empty_parents
    base = Base.new
    assert_equal [], base.instance_variable_get("@parents")
  end

  def test_non_empty_parents
    base = Base.new(:a,:b)
    assert_equal [:a,:b], base.instance_variable_get("@parents")
  end

  def test_enumarable
    assert( Base.new.each.is_a? Enumerator)
  end
end

class Human
  include Generation
  #notate :parents, :authors
  #notate :children, :documents 
end

class TestBook < MiniTest::Test
  def setup
    @man1 = Human.new
  end

  def test_class
    assert_equal @man1.class, Human
  end

  def test_attr
    # p @man1.parents
    assert @man1.parents
  end

end
