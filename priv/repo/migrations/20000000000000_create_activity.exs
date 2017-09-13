defmodule ExActivity.Repo.Migrations.CreateActivity do
  use Ecto.Migration

  def change do
    create table(:activity) do
      add :type, :string
      add :action, :string
      add :result, :string
      add :details, :string
      add :data, :string
      add :ip, :string
      add :user_agent, :string

      timestamps()
    end
  end
end
