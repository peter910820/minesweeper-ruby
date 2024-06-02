require "tk"
 
class Minesweeper
    def initialize
        @row = (0..9).to_a
        @col = (0..9).to_a
        @bomb_amount = 20
        @open_list = []
        @bomb_list = []
        @button_list = Array.new(@row[-1] + 1){Array.new(@col[-1] + 1)}
        @root = TkRoot.new do
            title "Minesweeper.exe"
            geometry "300x300"
            resizable false, false
        end
        # @board = TkLabel.new do
        #     text "板板"
        #     grid(row: 0, column: 5)
        # end
        generate_block
        generate_bomb
        puts @bomb_list.inspect
    end
    def generate_block
        @row.each do |row|
            @col.each do |col|
                @button = TkButton.new(@root) do
                    width 2
                    height 1
                    bg "grey"
                    grid(row: row, column: col)
                end
                @button.command(proc { click(row, col) })
                @button_list[row][col] = @button
            end
        end
    end

    def generate_bomb
        judge = 0
        while judge < @bomb_amount
            x = rand(0..9)
            y = rand(0..9)
            arr = [x, y]
            if @bomb_list.include?(arr)
                nil
            else
                @bomb_list.push(arr)
                judge += 1
            end
        end
    end

    def click(row, col)
        if @bomb_list.include?([row, col])
            @button_list[row][col].configure("bg", "red")
            @button_list[row][col].configure("state", "disabled")
        else
            open_block(@button_list[row][col], row, col)
            puts "#{row}, #{col}"
        end
    end

    def open_block(button, row, col)
        if row < 0 or col < 0
            nil
        elsif @open_list.include?([row, col])
            nil
        else
            puts [row, col].inspect
            @open_list.push([row, col])
            button.configure("bg", "white")
            button.configure("state", "disabled")
            around = [[row-1, col-1], [row-1, col], [row-1, col+1], [row, col-1], [row, col+1], [row+1, col-1], [row+1, col], [row+1, col+1]]
            puts around.inspect
            combo = 0
            around.each do |ar|
                if @bomb_list.include?(ar)
                    combo += 1
                end
            end
            if combo == 0
                button.configure("bg", "white")
                button.configure("state", "disabled")
                around.each do |ar|
                    puts "ssst"
                    if ar[0] > @row[-1] or ar[1] > @col[-1]
                        nil
                    else
                        open_block(@button_list[ar[0]][ar[1]], ar[0], ar[1])
                    end
                end
            else    
                button.configure("bg", "white")
                button.configure("state", "disabled")
                button.configure("text", combo)
            end
        end
    end

    def run
        Tk.mainloop
    end
end

app = Minesweeper.new
app.run