class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      display_tutorials
    end
  end

  private

  def display_tutorials
    @tutorials = if current_user
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.not_classroom_content.paginate(page: params[:page], per_page: 5)
                 end
  end
end
