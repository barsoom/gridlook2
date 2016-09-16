defmodule Gridlook2.Repo.Migrations.CreateEmailMessages do
  use Ecto.Migration

  def change do
    create table(:email_messages) do
      add :email, :string, null: false
      add :events, :map, null: false
      add :mailer_action, :string, null: false
      add :unique_args, :string, null: false

      timestamps
    end
  end
end
