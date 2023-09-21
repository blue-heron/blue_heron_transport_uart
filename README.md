# BlueHeronTransportUART

[![Hex version](https://img.shields.io/hexpm/v/blue_heron_transport_uart.svg "Hex version")](https://hex.pm/packages/blue_heron_transport_uart)
[![API docs](https://img.shields.io/hexpm/v/blue_heron_transport_uart.svg?label=hexdocs "API docs")](https://hexdocs.pm/blue_heron_transport_uart/BlueHeronTransportUART.html)
[![mix test](https://github.com/blue-heron/blue_heron_transport_uart/actions/workflows/elixir.yaml/badge.svg)](https://github.com/blue-heron/blue_heron_transport_uart/actions/workflows/elixir.yaml)

BlueHeron supports UART-based Bluetooth modules.

To use, add `:blue_heron_transport_uart` to your `mix.exs` dependencies and
adapt the following to initialize a transport context.

```elixir
config = %BlueHeron.HCI.Transport.UART{
  device: "/dev/ttyACM0",
  uart_opts: [speed: 115200],
}
{:ok, ctx} = BlueHeron.transport(config)
```

## License

The source code is released under the MIT license.

Check [NOTICE](NOTICE) and [LICENSE](LICENSE) files for more information.
