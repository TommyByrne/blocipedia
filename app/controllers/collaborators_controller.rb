class CollaboratorsController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    @collaborator.save
    redirect_to edit_wiki_path(@wiki)
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
    @users = User.search(params[:search])
    @wiki_id = params[:wiki_id]
  end
end