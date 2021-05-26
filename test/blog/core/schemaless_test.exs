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
      %{id: id, title: title, body: body} = post() |> Repo.insert!()

      q = from(p in Post, select: %Post{title: p.title, body: p.body})

      assert %Post{title: ^title, body: ^body} = Repo.get_by!(q, id: id)
    end

    test "without schema" do
      post = post() |> Repo.insert!()

      q = from("posts", select: [:title, :body])

      assert %{title: post.title, body: post.body} ==
               Repo.get_by!(q, id: Ecto.UUID.dump!(post.id))
    end
  end

  describe "updates a list of fields" do
    test "with schema" do
      %{id: id} = post() |> Repo.insert!()

      q = from p in Post, where: p.id == ^id

      assert {1, nil} = Repo.update_all(q, set: [title: "new title"])
    end

    test "without schema" do
      post = post() |> Repo.insert!()
      id = Ecto.UUID.dump!(post.id)

      q = from "posts", where: [id: ^id] # id == ^id doesn't work

      assert {1, nil} = Repo.update_all(q, set: [title: "new title"])
    end
  end


  defp post(fields \\ []) do
    %Post{
      title: fields[:title] || "some title",
      body: fields[:body] || "this is a post on something"
    }
  end
end
