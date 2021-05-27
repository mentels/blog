defmodule Blog.Core.Post do
  @moduledoc """
  Post model.
  """
  use Ecto.Schema

  alias Blog.Core.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "posts" do
    field(:title, :string)
    field(:body, :string)
    belongs_to(:user, User, type: Ecto.UUID)

    timestamps(type: :utc_datetime)
  end
end
