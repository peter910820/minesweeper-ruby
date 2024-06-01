require "tk"
 
class Minesweeper
    def initialize
        @row = (0..9).to_a
        @col = (0..9).to_a
        @bomb_amount = 20
        @bomb_list = []
        @root = TkRoot.new do
            title "calculator.exe"
            geometry "300x300"
            resizable false, false
        end
        # @board = TkLabel.new do
        #     text "板板"
        #     grid(row: row, column: col)
        # end
        generate_block
        generate_bomb
        print @bomb_list
    end
    def generate_block
        @row.each_with_index do |item, row|
            @col.each_with_index do |item, col|
                @button = TkButton.new(@root) do
                    text "1"
                    width 2
                    height 1
                    bg "grey"
                    grid(row: row, column: col)
                end
                @button.command(proc { click(row, col) })
            end
        end
    end

    def generate_bomb
        @bomb_amount.times do |i|
            x = rand(0..9)
            y = rand(0..9)
            arr = [x, y]
            @bomb_list.push(arr)
        end
    end

    def click(row, col)
        puts "#{row}, #{col}"
    end

    def run
        Tk.mainloop
    end
end

app = Minesweeper.new
app.run