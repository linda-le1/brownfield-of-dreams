class TutorialsController < ApplicationController
  def index
    @tutorials = if current_user
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.not_classroom_content.paginate(page: params[:page], per_page: 5)
                 end
  end

  def show
    tutorial = Tutorial.find(params[:id])
    render locals: {
      tutorial_facade: TutorialFacade.new(tutorial, params[:video_id], current_user)
    }
  end
end
