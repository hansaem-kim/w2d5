class Item

    attr_accessor :title, :deadline, :description
    attr_reader :done

    def self.valid_date?(date)
        date = date.split("-")
        year = date[0]
        month = date[1]
        day = date[2]
        return false if date.length != 3
        return false if year.to_i > 3000 || year.to_i < 1000
        return false if month.length != 2
        return false if month.to_i > 12 || month.to_i < 1
        return false if day.to_i > 31 || day.to_i < 1
        true
    end

    def initialize(title, deadline, description)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
        raise "Invalid Date" if !Item.valid_date?(@deadline)
    end

    def toggle
        if @done
            @done = false
        else
            @done = true
        end
        
    end

end

