class Admin::GenresController < ApplicationController
  
  
  def create
    genre = Genre.new(genre_params)
    genre.save
    flash[:success] = "ジャンルを追加しました。"
    redirect_to admin_genres_path
  end
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      flash[:success] = "ジャンルを編集しました。"
      redirect_to admin_genres_path
    else
      render :edit
      
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
