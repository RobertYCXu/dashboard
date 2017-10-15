class BoardsController < ApplicationController
	before_action :correct_user, only: [:show]
	before_action :logged_in_user, only: [:index, :create]
	def create
		@board = Board.new(board_params)
		@board.owner = current_user.id
		current_user.boards << @board
		if @board.save
			flash[:success] = "Successfully created new board!"
			redirect_to '/boards'
		else
			flash[:danger] = "Oops! Something went wrong."
			render '/boards'
		end
	end

	def index
		@boards = current_user.boards
	end
	def show
		@board = current_user.boards.find(params[:id])
		@notes = @board.notes
	end

	def destroy
		@board = Board.find(params[:id])
		if @board.destroy
			flash[:success] = "Successfully deleted board!"
		else
			flash[:danger] = "Oops! Something went wrong."
		end
		redirect_back(fallback_location: root_path)
	end

	private
		def board_params
			params.require(:board).permit(:name)
		end
		def correct_user
			redirect_to(boards_path) unless current_user.boards.exists?(id: params[:id])
		end
end
