class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user).paginate(page: params[:page], per_page: 15)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user_id = current_user.id
    title = @wiki.title

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error creating wiki please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

    def update
      @wiki = Wiki.find(params[:id])

      if @wiki.update_attributes(wiki_params)
        flash[:notice] = "Wiki was updated"
        redirect_to @wiki
      else
        flash[:error] = "There was an error updating the Wiki. Please try again."
        render :edit
      end
    end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the Wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
