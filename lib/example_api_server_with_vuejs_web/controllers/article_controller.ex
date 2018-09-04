defmodule ExampleApiServerWithVuejsWeb.ArticleController do
  use ExampleApiServerWithVuejsWeb, :controller

  alias ExampleApiServerWithVuejs.Blog
  alias ExampleApiServerWithVuejs.Blog.Article

  action_fallback ExampleApiServerWithVuejsWeb.FallbackController

  def index(conn, _params) do
    articles = Blog.list_articles()
    render(conn, "index.json", articles: articles)
  end

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <- Blog.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  def show(conn, %{"id" => id}) do
    article = Blog.get_article!(id)
    render(conn, "show.json", article: article)
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Blog.get_article!(id)

    with {:ok, %Article{} = article} <- Blog.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Blog.get_article!(id)
    with {:ok, %Article{}} <- Blog.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
