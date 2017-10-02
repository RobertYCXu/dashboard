class InvitationsController < ApplicationController
	def create
		if User.exists?(email: params[:recipient_email])
			recipient_id = User.find_by_email(params[:recipient_email]).id
			if !Invitation.exists?(board_id: params[:board_id], recipient_id: recipient_id, user_id: current_user.id)
				@invitation = Invitation.new(board_id: params[:board_id], recipient_id: recipient_id)
				current_user.invitations << @invitation
				if @invitation.save
					flash[:success] = "Successfully invited #{User.find(recipient_id).name} to #{Board.find(params[:board_id]).name}!"
				else
					flash[:danger] = "Oops! Something went wrong."
				end
			else
				flash[:danger] = "Already invited #{User.find(recipient_id).name} to this board."

			end
		else
			flash[:danger] = "User with that email doesn't exist."
		end
		redirect_to "/boards/#{params[:board_id]}"
	end

	def index
		@invitations = Inivitation.where({recipient_id: current_user.id})
	end

	def accept
		current_user.boards << Board.find(params[:board_id])
		current_user.save
		Invitation.find(params[:invitation_id]).destroy
		redirect_to root_path
	end

	def reject
		Invitation.find(params[:invitation_id]).destroy
		redirect_to root_path
	end
end
