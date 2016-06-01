  class Cell
  attr_reader :value
    def initialize(value = "-")
	@value = value
    end
  end

  class Grid
  attr_reader :board, :screen

#games board
    def initialize(board = []) 
  	cell = Cell.new	
  	  9.times do
  	  board.push(cell.value)
      end
    @board = board.each_slice(3).to_a
    end
    
    def display
    n = 0
    while n < 3 do
    puts board[n].join(" | ")
    n += 1
    end
    end

#game mechanics    
    
    def get(x,y)
    x -= 1
    y -= 1
    board[x][y]
    end
    
    def set
      if $turns.even?
      value = "o"
      else
      value = "x"	
      end 
     
     num = gets.chomp
     
     case num
     when "1"
       if self.board[0][0] == "-"
       self.board[0][0] = value
       else
       error
       end
     when "2"
       if self.board[0][1] == "-"
       self.board[0][1] = value
       else
       error
       end
     when "3"
      if self.board[0][2] == "-"
      self.board[0][2] = value
      else
      error
      end
     when "4"
       if self.board[1][0] == "-"
       self.board[1][0] = value
       else
       error
       end
     when "5"
      if self.board[1][1] == "-"
      self.board[1][1] = value
      else
      error
      end
     when "6"
      if self.board[1][2] == "-"
     self.board[1][2] = value
      else
      error
      end
     when "7"
      if self.board[2][0] == "-"
     self.board[2][0] = value
      else
      error
      end
     when "8"
      if self.board[2][1] == "-"
     self.board[2][1] = value
      else
      error
      end
     when "9"
      if self.board[2][2] == "-"
      self.board[2][2] = value
      else
      error
      end
     else
     error	
     end
    end
    
    def error
     puts "error try again"
     set
    end 
    
    def draw
     if $turns == 9
     self.display
     puts "Game over, Draw. New Game?(y/n)"
     newgame = gets.chomp.downcase
     end
     if newgame == "y"
     test = Play.new
     test.play  
     end
    end
#win conditions    
    def win?
    	# checks rows
      for i in 0..2	
        if self.board[i].all? {|value| value == self.board[i][0]}
          if self.board[i].any? {|value| value == "-"}
          else	
          self.winover?
          end
        end
        end
        #checks columns
      for j in 0..2
         columns = self.board.transpose
         if columns[j].all? {|value| value == self.board[j][0]}
         if columns[j].any? {|value| value == "-"}
         else	
         self.winover?
         end
        end
        end
      
      if self.board[0][0] == self.board[1][1] && self.board[0][0] == self.board[2][2]
      checks = [self.board[0][0],self.board[1][1],self.board[2][2]]	
        if checks.any? {|va| va == "-"}
      	nil
        else
        self.winover?
        end
      end
      
      if self.board[2][0] == self.board[1][1] && self.board[2][0] == self.board[0][2]
      check = [self.board[2][0],self.board[1][1],self.board[0][2]]	
      if check.any? {|va| va == "-"}
      nil
      else
      self.winover?
      end
      end
          
    end  
    
    def winover?
      if $turns.even?	
      player = "player1"
      else
      player = "player2"
      end
    self.display	
    puts "Game over, #{player} wins!!!. New Game?(y/n)"
    newgame = gets.chomp.downcase
      if newgame == "y"
      test = Play.new
      test.play 
      else 
      exit 
      end
    end
      
  end
 
  class Play
    def play
    $turns = 0
    games = Grid.new
      9.times do
      games.display
        if $turns.even? 
        puts "Player 1 move enter 1-9"
        else
        puts "Player 2 move enter 1-9"
        end
      games.set
      games.win?
      $turns += 1
      games.draw
      end
    end
  end

test = Play.new
test.play