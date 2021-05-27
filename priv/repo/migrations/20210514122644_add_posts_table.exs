defmodule Blog.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  # PKeys, IDs and timestamps are defined in config
  def change do
    create table("posts") do
      add :title, :string
      add :body, :text
      add :user_id, references("users", type: :uuid)

      timestamps()
    end
  end
end
