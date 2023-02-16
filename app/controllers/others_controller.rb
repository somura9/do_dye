class OthersController < ApplicationController
  skip_before_action :require_login
  def terms; end

  def privacy; end

  def how_to; end
end
