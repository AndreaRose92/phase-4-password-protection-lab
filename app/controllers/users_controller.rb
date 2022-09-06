class UsersController < ApplicationController
    
    def create
        u = User.create(user_params)
        if u.valid?
            render json: u, status: :created
            session[:user_id] = u.id
        else
            render json: {errors: u.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        u = User.find_by(id: session[:user_id])
        if u
            render json: u
        else
            render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
