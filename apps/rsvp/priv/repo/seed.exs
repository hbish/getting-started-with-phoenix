unless(Rsvp.EventQueries.any()) do
  Rsvp.EventQueries.create(
    Rsvp.Events.changeset(%Rsvp.Events{}, %{
      date: "2019-11-22 00:00:00",
      title: "Coding Camp",
      location: "Sydney"
    })
  )

  Rsvp.EventQueries.create(
    Rsvp.Events.changeset(%Rsvp.Events{}, %{
      date: "2019-05-22 00:00:00",
      title: "Scout Camp",
      location: "Manly"
    })
  )
end
