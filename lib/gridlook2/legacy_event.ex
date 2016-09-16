defmodule Gridlook2.LegacyEvent do
  use Ecto.Schema

  alias Gridlook2.EmailMessage

  def to_email_message(legacy_events) do
    first_event = hd(legacy_events)

    events = legacy_events
      |> Enum.map(fn (event) ->
        event.unique_args
      end)

    %EmailMessage{
      email: first_event.email,
      mailer_action: first_event.mailer_action,
      #created_at: first_event.created_at,
      #updated_at: first_event.updated_at,
      events: events,
    }
  end

  schema "events" do
    field :email, :string
    field :name, :string
    field :category, :string
    field :data, :string
    field :happened_at, Ecto.DateTime
    field :unique_args, :string
    field :mailer_action, :string

    timestamps inserted_at: :created_at
  end
end
