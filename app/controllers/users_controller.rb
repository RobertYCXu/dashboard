class UsersController < ApplicationController
	before_action :logged_in_user, only: [:create, :show]
	def show
		@user = User.find(params[:id])
	end

	# def create_note
	# 	@note = Note.new(note_params)
	# 	current_user.notes << @note
	# 	if @note.save
	# 		flash[:success] = "Successfully created new note!"
	# 		redirect_to '/notes'
	# 	else
	# 		flash[:danger] = "Oops! Something went wrong."
	# 		render '/notes'
	# 	end
	# end

	# private
	# 	def note_params
	# 		params.require(:user).permit(:note)
	# 	end

end
