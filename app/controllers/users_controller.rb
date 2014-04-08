class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:update_card_details, :show, :edit_card_details]
  
  def index
    @users = User.all
  end

  def show
  end
  
  def edit_card_details
    render 'edit_card_details'
  end
  
  def update_card_details
    respond_to do |format|
      if @user.update(card_update_params)
        format.html { redirect_to @user, notice: 'User card details was successfully updated.' }
        format.json { render action: 'show', status: :ok, location: @user }
      else
        format.html { render action: 'edit_card_details' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def authenticate
    respond_to do |format|
      @user = User.where(facility_code: params[:facility_code], id_code: params[:id_code])
      if @user.count == 1
        user = @user[0]
        if user.has_any_role? :admin, :oboard, :crew_chief, :driver
          format.html{ render html: "authorized" }
          format.json{ render json: "authorized" }
        else
          format.html{ render html: "forbidden", status: :forbidden }
          format.json{ render json: "forbidden", status: :forbidden }
        end
      else
        format.html{ render html: "forbidden", status: :forbidden }
        format.json{ render json: "forbidden", status: :forbidden }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
  # Never trust parameters from the scary internet, only allow the white list through.
    def card_update_params
      params.require(:user).permit(:facility_code, :id_code)
    end

end
