class ArticlesController < ApplicationController
  helper_method :sort_column, :sort_direction

  http_basic_authenticate_with name: "admin", password: "password", except: [:index, :show]

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.order(sort_column + ' ' + sort_direction)
    @average_length = @articles.average_text_length
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    @article.text_length
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :text)
    end

    def sort_column
      Article.column_names.include?(params[:sort]) ? params[:sort] : "title"
    end

    def sort_direction
      %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
    end
end
