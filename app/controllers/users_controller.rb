class UsersController < ApplicationController
    def index
        if session[:user_id]
            @user=User.find(session[:user_id])
            if @user.expenses.any? 
                @expenses= @user.expenses.where(is_accpted: nil)
            end
        puts 'inside index if '
        end
    end

    def login
        render 'login'
    end

    def loggedin
      user=User.find_by(email: params[:email])
      if user.present? && user.authenticate(params[:password])
          session[:user_id]=user.id
      end
      redirect_to '/users'
    end

    def destroy
            session[:user_id]=nil
            redirect_to '/users'
    end
   
    def expenses
        if session[:user_id]
            @expense=Expense.new
            @user=User.find(session[:user_id])
            render 'expenses'
        else
            redirect_to '/users'
        end
    end

    def UsersController.fetchingapi(invoicenum)
        api_key ='b490bb80'
        uri='https://my.api.mockaroo.com/invoices.json'
        res=Net::HTTP.post URI('https://my.api.mockaroo.com/invoices.json'),
        {"invoice_id" => invoicenum}.to_json,
        'X-API-Key' => "b490bb80"
         return JSON.parse(res.body)
    end

    def handler
        expenses=Expense.create(expense_params)
        expenses.save
        res=UsersController.fetchingapi(expenses.invoicenum)
        exp=Expense.last
        value= res['status']
        puts exp.is_accpted
            if !res["status"]
                exp.is_accpted = "false"
                exp.save
                puts "its falsee"
            end
        puts exp.is_accpted
        redirect_to '/users'
    end

    def expense_params
        params.require(:expense).permit(:invoicenum,:description,:amount,:date,:user_id,:bill)
    end


    def accepted
        if session[:user_id]
            @user=User.find(session[:user_id])
            @expenses=@user.expenses.where(is_accpted:'true')
            render 'index'
        else
            redirect_to '/users'
          end
          
    end

    def rejected
        if session[:user_id]
            @user=User.find(session[:user_id])
            @expenses=@user.expenses.where(is_accpted:'false')
            render 'index'
        else
            redirect_to '/users'
        end   
    end

    def search
        @expense = Expense.find(params[:id])
        @user = User.find(@expense.user_id)
        render 'showuser'
    end

    def comment
        comment = Comment.create(description:params[:description],expense_id:params[:expense_id],name:params[:name])
        user=User.find(session[:user_id])
        if user.role == 'admin'
            expense=Expense.find(params[:expense_id])
            @user=User.find(expense.user_id)
            puts @user.email
        else
            @user=User.find_by(role:'admin')
            puts @user.email
        end
        if comment.save
            UserMailer.with(user:@user).comment_mail.deliver_now
            redirect_to '/users'
        else 
           redirect_to '/admin'
        end
    end
end