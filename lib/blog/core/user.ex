defmodule Blog.Core.User do
  @moduledoc """
  User model.
  """

  use Ecto.Schema

  alias Blog.Core.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type Ecto.UUID
  schema "users" do
    field(:name, :string)
    field(:surname, :string)
    field(:email, :string)

    has_many(:posts, Post)
  end
end
