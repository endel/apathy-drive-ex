defmodule Commands.Attack do
  use ApathyDrive.Command

  def keywords, do: ["attack", "a", "kill", "k"]

  def execute(%Spirit{} = spirit, _arguments) do
    spirit
    |> Spirit.send_scroll("<p>You need a body to do that.</p>")
  end

  def execute(_spirit, monster, arguments) do
    current_room = Parent.of(monster)

    target = current_room |> find_entity_in_room(monster, Enum.join(arguments, " "))
    attack(monster, target)
  end

  defp attack(entity, nil) do
    send_message(entity, "scroll", "<p>Attack what?</p>")
  end

  defp attack(entity, target) do
    send_message(entity, "scroll", "<p><span class='dark-yellow'>You move to attack #{Components.Name.value(target)}!</span></p>")
    Systems.Combat.attack(entity, target)
  end

  defp find_entity_in_room(room, monster, string) do
    room
    |> Systems.Room.living_in_room
    |> Enum.reject(&(&1 == monster))
    |> Systems.Match.one(:name_contains, string)
  end

end
