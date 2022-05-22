class AdminsController < ApplicationController

    def index
      if session[:user_id]
        @user=User.find(session[:user_id]) 
        if @user.role == 'admin'
         if @name.nil?
           @users=User.all
         else
           @users=User.where(name: @name)
        end
        else 
          redirect_to '/destroy'
        end
      end
    end

   def create
    @user = User.new(user_params)
    if @user.save
         redirect_to '/admin'
    else
         render 'signup',notice:'Invalid '
    end
   end

   def login
      render 'login'
   end

   def signup
      if(session[:user_id])
        @user=User.new
        render 'signup'
      else
         redirect_to '/admin',notice:'Enter strong password orcorrect email'
      end
   end

    def sessions
        user=User.find_by(email: params[:email])
            
        if user.present? && user.authenticate(params[:password]) 
           if user.role == 'admin'
           session[:user_id]=user.id
            redirect_to '/admin'
           end
        else
        
            redirect_to '/admin/login'
        end
    end

    def destroy
        session[:user_id]=nil
        redirect_to '/admin'
    end

    def show
        if session[:user_id]
         @user=User.find_by(id: params[:id])
        # @expenses=@user.expenses.where(is_accpted)
         else
            redirect_to '/admin'
        end
    end

    def user_params
        params.require(:user).permit(:name,:email,:department,:role,:status,:password,:password_confirmation)
    end

   def search
        if session[:user_id]
        @expense = Expense.find(params[:id])
        @user = User.find(@expense.user_id)
        @user1=User.find(session[:user_id])
        render 'showexpenses'
        end

    end

    def accept
        @expense =Expense.find(params[:id])
        @expense.is_accpted = 'true'
        @expense.save
        puts @expense.is_accpted
        redirect_to '/admin'
    end

    def reject 
        @expense=Expense.find(params[:id])
        @expense.is_accpted='false'
        @expense.save
        redirect_to '/admin'
    end

    def comment
        comment=Comment.create(description:params[:description],expense_id:params[:expense_id],name:params[:name])
        user3=User.find(session[:user_id])
        if user3.role.include?'admin'
            
            expense=Expense.find(params[:expense_id])
            @user=User.find(expense.user_id)
            puts @user.id
        else
            @user=User.find_by(role:'admin')
            # puts @user.email
        end
         if comment.save
            UserMailer.with(user:@user).comment_mail.deliver
            redirect_back fallback_location: { action: "show"}
        else
            redirect_to '/admin'
        end
    end
    

    def searchmethod
        if session[:user_id]
        @user=User.find(session[:user_id])
        @users=User.where(name:params[:name])

        @name=params[:name]
        render 'index'
        else redirect_to '/users'
        end
    end
    def show_image
      
      @expense = Expense.find(params[:id])
      send_data @expense.bill, :type => 'image/png',:disposition => 'inline'
    end
end