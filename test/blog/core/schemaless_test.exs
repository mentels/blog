defmodule Blog.Core.SchemalessTests do
  use ExUnit.Case

  alias Blog.Core.Post
  alias Blog.Repo

  import Ecto.Query

  describe "selects a list of fields" do
    test "with schema 1" do
      post = post() |> Repo.insert!()

      q = from(p in Post, select: [p.title, p.body])

      assert [post.title, post.body] == Repo.get_by!(q, id: post.id)
    end

    test "with schema 2" do
      post = post() |> Repo.insert!()

      q = from(p in Post, select: %Post{title: p.title, body: p.body})

      assert post = Repo.get_by!(q, id: post.id)
    end

    test "without schema" do
      post = post() |> Repo.insert!()

      q = from("posts", select: [:title, :body])

      assert %{title: post.title, body: post.body} ==
               Repo.get_by!(q, id: Ecto.UUID.dump!(post.id))
    end
  end

  defp post(fields \\ []) do
    %Post{
      title: fields[:title] || "some title",
      body: fields[:body] || "this is a post on something"
    }
  end
end
