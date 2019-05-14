class PagesController < ApplicationController
  include UsersHelper

  def home
    @tree_data = TodoTreeConverter.new(current_house&.todos).run
  end
end
