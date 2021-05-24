defmodule Blog.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  def change do
    create table("posts") do
      add :title, :string
      add :body, :text
      add :user_id, references("users", type: :uuid)

      timestamps()
    end
  end
end
