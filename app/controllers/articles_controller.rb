class ArticlesController < ApplicationController
  
  http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show, :search]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy!

    redirect_to root_path
  end

  def search
    @articles = Article.where("title ILIKE :q or body ILIKE :q", q: "%#{params[:q]}%")
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
