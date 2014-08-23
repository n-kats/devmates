# coding: UTF-8
require 'yaml'

class Node
  def initialize(parent=nil)
    @parent = parent
    @children = []
    @secret_children = []
  end
end

class State

  def initialize(node)
    @doing = node
  end

  def done

  end

  def todo_list
  end

  def new_task
  end
  
end

module Command

  SKECH = {
    start: :show_tasks,
    show_tasks: :chose_task,
    chose_task: [ :work, :fix ],
    fix: :show_tasks,
    work: [
      :complete,
      :new_task,
      :wander,
      :give_up
    ],
    complete: :show_tasks,
    new_task: :add_children,
    wander: :add_secret_children,
    
    show_tasks: :work,
    add_children: :work,
    add_secret_children: :work

  }

  class << self
    def setup
      setting = YAML.load(File.read './todo.yml')

      SKECH.each do |k,v|
        case v
        when Symbol
          define_method(k) do
            puts v
          end
        when Array

        else 
          raise
        end
      end
    end

    def show_tasks
      puts "これだけすることがあります"
    end

    def ask_todo
      puts ""
    end

    def show_doing_task
    end

    def waiting_task

    end

    def task_completed

    end

    def new_task 
    end

    def wandering

    end

    def for_next_task
      #sleep 2
      exit
    end

    def run
      setup
      loop do
        show_tasks
        ask_todo
        show_doing_task
        waiting_task
        for_next_task
      end
    end
    alias start run
  end
end

Command::start

