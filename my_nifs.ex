
defmodule :my_nifs do

  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif('./obj/development/Erlang_Nifs', 0)
  end

  def increment(_n) do
    raise "NIF increment/1 not implemented"
  end

  def negate(_n) do
    raise "NIF negate/1 not implemented"
  end

  def uppercase(_n) do
    raise "NIF uppercase/1 not implemented"
  end

  def uppercase_binary(_n) do
    raise "NIF uppercase_binary/1 not implemented"
  end

end
