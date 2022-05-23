class UserMailer < ApplicationMailer

    def comment_mail 
        @user = params[:user]
        mail(to: @user.email,subject: "#{@user.name} has commented on your post")
    end
    def validatemail
        @user = params[:user]
        mail(to: @user.email,subject: "New expense created")
    end
end
