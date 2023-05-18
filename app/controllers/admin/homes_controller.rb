class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top #注文履歴一覧
  end
end
