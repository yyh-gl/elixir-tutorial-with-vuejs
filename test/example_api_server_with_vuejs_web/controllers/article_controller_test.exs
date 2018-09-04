defmodule ExampleApiServerWithVuejsWeb.ArticleControllerTest do
  use ExampleApiServerWithVuejsWeb.ConnCase

  alias ExampleApiServerWithVuejs.Blog
  alias ExampleApiServerWithVuejs.Blog.Article

  @create_attrs %{body: "some body", title: "some title"}
  @update_attrs %{body: "some updated body", title: "some updated title"}
  @invalid_attrs %{body: nil, title: nil}

  def fixture(:article) do
    {:ok, article} = Blog.create_article(@create_attrs)
    article
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all articles", %{conn: conn} do
      conn = get conn, article_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create article" do
    test "renders article when data is valid", %{conn: conn} do
      conn = post conn, article_path(conn, :create), article: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, article_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some body",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, article_path(conn, :create), article: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update article" do
    setup [:create_article]

    test "renders article when data is valid", %{conn: conn, article: %Article{id: id} = article} do
      conn = put conn, article_path(conn, :update, article), article: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, article_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body" => "some updated body",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, article: article} do
      conn = put conn, article_path(conn, :update, article), article: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete article" do
    setup [:create_article]

    test "deletes chosen article", %{conn: conn, article: article} do
      conn = delete conn, article_path(conn, :delete, article)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, article_path(conn, :show, article)
      end
    end
  end

  defp create_article(_) do
    article = fixture(:article)
    {:ok, article: article}
  end
end
