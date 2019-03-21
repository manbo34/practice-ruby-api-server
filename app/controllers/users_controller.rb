class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users/1/follow
  def follow
    sql = "select u.* from follows f
    inner join users u
    on f.user_id == u.id
    where f.follow_id == #{params[:id]}"

    render json: ActiveRecord::Base.connection.select_all(sql)
  end

  # GET /users/1/follower
  def follower
    sql = "select u.* from follows f
    inner join users u
    on f.follow_id == u.id
    where f.user_id == #{params[:id]}"

    render json: ActiveRecord::Base.connection.select_all(sql)
  end

  def direct_message
    sql = "select d.message, u.*
from direct_messages d
       inner join users u
                  on d.from_id == u.id
where d.to_id == #{params[:id]}
order by d.created_at desc
"

    render json: ActiveRecord::Base.connection.select_all(sql)
  end

  def tweet
    render json: Tweet.joins(:user).select("users.*, tweets.*").where(:user_id => params[:id])
  end

  def time_line
    sql = "
  select *
from tweets t
       inner join users u
                  on u.id == t.user_id
       left join (select count(*) as favorites, t.id as favo_id
                  from tweets t
                         inner join favorites f
                                    on t.id == f.tweet_id
                  group by tweet_id)
                 on favo_id == t.id
where t.user_id in (select follow_id from follows where follows.user_id == #{params[:id]})
   or t.user_id == #{params[:id]}
order by t.updated_at desc
"
    render json: ActiveRecord::Base.connection.select_all(sql)
  end

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :token)
  end
end
