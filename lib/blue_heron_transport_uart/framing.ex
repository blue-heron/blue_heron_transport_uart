defmodule BlueHeronTransportUART.Framing do
  @moduledoc """
  A framer module that defines a frame as a HCI packet.

  Reference: Version 5.0, Vol 2, Part E, 5.4
  """

  @behaviour Circuits.UART.Framing

  def init(_args), do: {:ok, <<>>}

  def add_framing(data, rx_buffer) when is_binary(data) do
    {:ok, data, rx_buffer}
  end

  def frame_timeout(rx_buffer), do: {:ok, [rx_buffer], <<>>}
  def flush(:transmit, rx_buffer), do: rx_buffer
  def flush(:receive, _rx_buffer), do: <<>>
  def flush(:both, _rx_buffer), do: <<>>

  def remove_framing(data, rx_buffer), do: process_data(rx_buffer <> data, [])

  defp process_data(<<0x02, header::little-16, length::little-16, data::binary-size(length), rest::binary>>, messages) do
    message = <<0x02, header::little-16, length::little-16, data::binary-size(length)>>
    process_data(rest, messages ++ [message])
  end

  defp process_data(<<0x04, event_code::size(8), length::size(8), event_parameters::binary-size(length), rest::binary>>, messages) do
    message = <<0x04, event_code::size(8), length::size(8), event_parameters::binary-size(length)>>
    process_data(rest, messages ++ [message])
  end

  defp process_data(<<>>, messages) do
    {:ok, messages, <<>>}
  end

  defp process_data(partial, messages) do
    {:in_frame, messages, partial}
  end
end
