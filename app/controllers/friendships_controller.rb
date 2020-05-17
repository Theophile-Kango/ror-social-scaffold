class FriendshipsController < ApplicationController
    def create
        current_user.friendships.create(friendship_params)
        redirect_to users_path
    end

    def send_invitation
        if current_user.send_invitation(params[:user_id])
            flash.notice = 'invitation sent'
        redirect_to users_path
        else
            flash.notice = 'error occured'
            redirect_to users_path
        end
    end

    def accept_invitation
     if current_user.confirm_invites(params[:user_id])
        flash.notice = 'friend accepted'
      redirect_to users_path
     else
        flash.notice = 'error occured'
     end
    end
    
    def reject_invitation
      current_user.reject_invites(params[:user_id])
      redirect_to users_path
    end

    def pending_invitation
    @pending_invitation = current_user.pending_invites
    end

    def destroy
      user = User.find(params[:user_id])
      friend = current_user.friendships.find_by_friend_id(user)
      if friend.destroy
        flash.notice = 'friend deleted'
      redirect_to users_path
      else
        flash.notice = 'error occurred'
      end
    end

    def friendship_params
        params.require(:friendship).permit(:friend_id, :status)
    end

end
