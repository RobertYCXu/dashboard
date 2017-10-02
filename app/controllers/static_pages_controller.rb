class StaticPagesController < ApplicationController
	def index
		if user_signed_in?
		@invitations = Invitation.where(recipient_id: current_user.id)
		@notes = current_user.notes
		end
	end
end
