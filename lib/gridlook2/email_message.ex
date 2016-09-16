defmodule Gridlook2.EmailMessage do
  use Ecto.Schema

  schema "email_messages" do
    field :email, :string
    field :mailer_action, :string
    field :events, :map
    #field :body, :string

    timestamps
  end
end
