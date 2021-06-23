require_relative "item"

class List

    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end 

    def add_item(title, deadline, description="")
        if Item.valid_date?(deadline)
            @items << Item.new(title, deadline, description)
            return true
        end
        false
    end

    def size
        return @items.length
    end

    def valid_index?(index)
        if index < 0 || index > self.size
            return false
        end
        true
    end

    def swap(i, j)
        if !self.valid_index?(i) || !self.valid_index?(j)
            return false
        end
        @items[i], @items[j] = @items[j], @items[i]
        true
    end

    def [](index)
        return nil if !self.valid_index?(index)
        @items[index]
    end

    def priority
        @items[0]
    end
    
    def print
        puts "--------------------------------------------------"
        puts @label.upcase
        puts "--------------------------------------------------"
        puts "Index  | Item                | Deadline     | Done  "
        puts "--------------------------------------------------"
        @items.each.with_index do |item, i|
            puts "#{i.to_s.ljust(7)}| #{item.title.ljust(17)}   | #{item.deadline.ljust(12)} | #{item.done}"
        end
        return nil
    end

    def print_full_item(index)
        if self.valid_index?(index)
            puts "----------------------------------------"
            puts @items[index].title
            puts @items[index].deadline
            puts @items[index].description
            puts @items[index].done
            puts "----------------------------------------"
        end
    end

    def print_priority
        self.print_full_item(0)
    end

    def up(index, amount=1)
        goal_index = index-amount-1
        goal_index = 0 if goal_index < 0
        return false if !self.valid_index?(index)
        while index > goal_index
            @items[index], @items[index-1] = @items[index-1], @items[index]
            index -= 1
        end
        return true
    end

    def down(index, amount=1)
        goal_index = index+amount
        goal_index = self.size-1 if goal_index > self.size-1
        return false if !self.valid_index?(index)
        while index < goal_index
            @items[index], @items[index+1] = @items[index+1], @items[index]
            index += 1
        end
        return true
    end

    def sort_by_date!
        @items.sort_by!{|item| item.deadline}
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        return false if !self.valid_index?(index)
        @items.delete_at(index)
        return true
    end

    def purge
        @items.each do |item|
            if item.done
                @items.delete(item)
            end
        end
    end


end