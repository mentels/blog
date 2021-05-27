defmodule Blog.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  # PKeys, IDs and timestamps are defined in config
  def change do
    create table("users") do
      add :name, :string
      add :surname, :string
      add :email, :string

      timestamps()
    end
  end
end
