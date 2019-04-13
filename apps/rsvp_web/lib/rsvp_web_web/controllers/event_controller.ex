defmodule RsvpWebWeb.EventController do
  use RsvpWebWeb, :controller

  plug RsvpWeb.AuthorizedPlug, "create" when action in [:create]

  def show(conn, %{"id" => id}) do
    event =
      Rsvp.EventQueries.get_by_id(id)
      |> IO.inspect()

    render(conn, "details.html", event: event)
  end

  def create(conn, %{errors: errors}) do
    render(conn, "create.html", changeset: errors)
  end

  def create(conn, _params) do
    changeset = Rsvp.Events.changeset(%Rsvp.Events{}, %{})
    render(conn, "create.html", changeset: changeset)
  end

  def list(conn, _params) do
    events = Rsvp.EventQueries.get_all()
    render(conn, "list.html", events: events)
  end

  def add(conn, %{"events" => events}) do
    naive_event_date = convert_date(events["date"])
    events = Map.replace!(events, "date", naive_event_date)

    changeset = Rsvp.Events.changeset(%Rsvp.Events{}, events)

    case Rsvp.EventQueries.create(changeset) do
      {:ok, %{id: id}} -> redirect(conn, to: Routes.event_path(conn, :show, id))
      {:error, reasons} -> create(conn, %{errors: reasons})
    end
  end

  def reserve(conn, %{"id" => id, "reservation" => %{"quantity" => quantity}}) do
    {:ok, event} = Rsvp.EventQueries.decrease_quantity(id, quantity)
    RsvpWeb.EventChannel.send_update(event)
    redirect(conn, to: Routes.event_path(conn, :show, id))
  end

  def convert_date(date) do
    {_, new_date} =
      (date <> ":00")
      |> NaiveDateTime.from_iso8601()

    new_date
  end
end
