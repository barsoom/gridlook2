defmodule Gridlook2.LegacyRepo do
  use Ecto.Repo, otp_app: :gridlook2
  import Ecto.Query

  alias Gridlook2.LegacyEvent

  def email_messages do
    events_grouped_by_sg_message_id
    |> Enum.map(fn {sgid, events} ->
      Gridlook2.LegacyEvent.to_email_message(events)
    end)
  end

  def events_grouped_by_sg_message_id do
    ids_grouped_by_sg_message_id
    |> Enum.map(fn {sgid, event_ids} ->
      {sgid, all(from e in LegacyEvent, where: e.id in ^event_ids)}
    end)
  end

  def ids_grouped_by_sg_message_id do
    ids_and_sg_message_ids
    |> Enum.group_by(fn ({id, sgid}) ->
      sgid
    end)
    |> Enum.map(fn ({sgid, list}) ->
      {sgid, Enum.map(list, fn ({id, sgid}) -> id end)}
    end)
  end

  def ids_and_sg_message_ids do
    query = from e in LegacyEvent, order_by: e.id

    offset = 0
    fetch_data(query, offset, [])
  end

  def fetch_data(query, offset, acc) do
    query = from e in query, limit: 10000, offset: ^offset

    result = all(query)
      |> Enum.map(fn (event) ->
        {event.id, event.unique_args |> String.split("sg_message_id: ") |> Enum.reverse |> hd |> String.split("\n") |> hd}
      end)

    if result == [] || offset > 10_000 do
      acc
    else
      fetch_data(query, offset + 10000, acc ++ result)
    end
  end

  def find_bounced do
    query = from e in LegacyEvent, where: e.name == "bounce", limit: 100_000
    all(query)
  end
end
