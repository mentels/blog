defmodule Blog.Core.OtherTest do
  use ExUnit.Case

  alias Blog.Core.{Post, User}
  alias Blog.Repo

  import Ecto.Query

  test "select_merge" do
    %User{id: id} =
      [posts: [post()]]
      |> user()
      |> Repo.insert!()

    for include_title? <- [true, false] do
      assert %{name: "John", surname: "Doe"}
             |> then(&((include_title? && Map.put(&1, :title, "some title")) || &1)) ==
               User
               |> join(:inner, [u], p in assoc(u, :posts))
               # from(u in User, join: p in assoc(u, :posts), where: u.id == ^id)
               |> where([u], u.id == ^id)
               # if this line is skipped the source is seen as nil and select_merge doesn't work
               |> select(%{})
               # %{name: u.name, surname: u.surname} could be used instead of map/2
               |> select_merge([u], map(u, [:name, :surname]))
               # ... stands for "all bindings before the last one"
               |> then(
                 &if include_title?, do: select_merge(&1, [..., p], %{title: p.title}), else: &1
               )
               |> Repo.one()
    end
  end

  defp post(fields \\ []) do
    %Post{
      title: fields[:title] || "some title",
      body: fields[:body] || "this is a post on something"
    }
  end

  def user(fields \\ []) do
    %User{
      name: fields[:name] || "John",
      surname: fields[:surname] || "Doe",
      email: fields[:email] || "john@doe.net",
      posts: fields[:posts]
    }
  end
end
