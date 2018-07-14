class AccountsController < ApplicationController
  
  before_filter :verify_admin
  before_filter :set_account, except: [:index]

  def index
    @accounts = Account.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
  end

  def destroy
    @account.destroy
    redirect_to action: :index
  end

  private

  def set_account
    @account = Account.find params[:id]
  end

end
