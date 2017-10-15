class NotesController < ApplicationController
	before_action :logged_in_user, only: [:create]
	def create_user_note
		@note = Note.new(note: params[:note])
		@note.user = current_user
		if @note.save
			flash[:success] = "Successfully created new note!"
		else
			flash[:danger] = "Oops! Something went wrong."
		end
		redirect_to root_path
	end

	def create_board_note
		@note = Note.new(note: params[:note])
		@note.board_id = params[:board_id]
		if @note.save
			flash[:success] = "Successfully created new note!"
		else
			flash[:danger] = "Oops! Something went wrong."
		end
		redirect_to "/boards/#{params[:board_id]}"
	end

	def destroy
		@note = Note.find(params[:id])
		if @note.destroy
			flash[:success] = "Successfully deleted note!"
		else
			flash[:danger] = "Oops! Something went wrong."
		end
		redirect_back(fallback_location: root_path)
	end
end
