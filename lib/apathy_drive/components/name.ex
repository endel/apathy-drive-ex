defmodule Components.Name do
  use Systems.Reload
  use GenEvent

  ### Public API
  def value(entity) do
    GenEvent.call(entity, Components.Name, :get_name)
  end

  def get_name(entity) do
    value(entity)
  end

  def value(entity, new_value) do
    GenEvent.notify(entity, {:set_name, new_value})
  end

  def serialize(entity) do
    %{"Name" => get_name(entity)}
  end

  ### GenEvent API
  def init(name) do
    {:ok, name}
  end

  def handle_call(:get_name, name) do
    {:ok, name, name}
  end

  def handle_event({:set_name, new_value}, _value) do
    {:ok, new_value }
  end

  def handle_event(_, current_value) do
    {:ok, current_value}
  end
end