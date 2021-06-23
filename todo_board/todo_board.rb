require_relative "item"
require_relative "list"

class TodoBoard

    def initialize()
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, label,*args = gets.chomp.split(' ')

        case cmd
        when 'mklist'
            @lists[label] = List.new(label)
        when 'ls'
            @lists.each {|k,v| puts v.label}
        when 'showall'
            @lists.each {|k,v| v.print}
        when 'purge'
            @lists[label].purge
        when 'toggle'
            @lists[label].toggle_item(args[0].to_i)
        when "rm"
            @lists[label].remove_item(args[0].to_i)
        when 'mktodo'
            @lists[label].add_item(*args)
        when 'up'
            @lists[label].up(*args.map(&:to_i))
        when 'down'
            @lists[label].down(*args.map(&:to_i))
        when 'swap'
            @lists[label].swap(*args.map(&:to_i))
        when 'sort'
            @lists[label].sort_by_date!
        when 'priority'
            @lists[label].print_priority
        when 'print'
            if args.length == 0
                @lists[label].print
            else
                @lists[label].print_full_item(args[0].to_i)
            end
        when 'quit'
            return false
        else
            print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        while true
            return if !get_command
        end
    end
end

board = TodoBoard.new

board.run