class UsersController < ApplicationController
  before_action :signed_in_user,    only: [:edit, :update, :index, :destroy]
	before_action :correct_user,      only: [:edit, :update]
  before_action :admin_user,        only: :destroy
  before_action :already_signed_in, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
		@user = User.find(params[:id])
	end
	
  def new
  	@user = User.new
  end

	def create
		@user = User.create(user_params)
		if @user.save
			sign_in @user
      flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User information changed successful"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if !@user.admin 
      @user.destroy
      flash[:success] = "User deleted."
    else
      flash[:notice] = "User #{@user.name} is an administrator"
    end
    redirect_to users_url
  end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

    #Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def already_signed_in
      #redirect_to(root_url) unless !current_user.nil?
    end
end
