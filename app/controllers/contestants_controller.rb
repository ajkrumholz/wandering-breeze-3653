class ContestantsController < ApplicationController
  def index
    @contestants = Contestant.all
  end

  def create
    project = Project.find(params[:project_id])
    project.contestants.create(cont_params)
    redirect_to "/projects/#{project.id}"
  end

  private
  def cont_params
    params.permit(:name, :age, :hometown, :years_of_experience)
  end
end

