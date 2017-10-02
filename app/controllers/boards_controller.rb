class BoardsController < ApplicationController
	before_action :correct_user, only: [:show]
	before_action :logged_in_user, only: [:index]
	def create
		@board = Board.new(board_params)
		@board.owner = current_user.id
		current_user.boards << @board
		if @board.save
			flash[:success] = "Successfully created new board!"
			redirect_to '/boards'
		else
			render '/boards'
		end
	end

	def index
		@boards = current_user.boards
	end
	def show
		
		@board = current_user.boards.find(params[:id])
	end

	private
		def board_params
			params.require(:board).permit(:name)
		end
		def correct_user
			redirect_to(boards_path) unless current_user.boards.exists?(id: params[:id])
		end
end
