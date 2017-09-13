defmodule ExActivity.Repo.Migrations.ChangeActivity do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE activity MODIFY details LONGTEXT;"
    execute "ALTER TABLE activity MODIFY data LONGTEXT;"
  end

  def down do
    execute "ALTER TABLE activity MODIFY details VARCHAR(255);"
    execute "ALTER TABLE activity MODIFY data VARCHAR(255);"
  end
end
