class CollaboratorsController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where(email: params[:email]).take
    collaborator = @wiki.collaborators.build(user_id: @user.id)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed from wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "Collaborator could not be removed."
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def search
    raise
    @users = User.search(params[:search])
  end
end