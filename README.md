# CircleCi

[![Hex version](https://img.shields.io/hexpm/v/circle_ci.svg "Hex version")](https://hex.pm/packages/circle_ci)

A wrapper for interfacing with the CircleCI API.
Additional information can be found in the API reference
https://circleci.com/docs/api/v1-reference

[Documentation](https://hexdocs.pm/circle_ci)


# Usage

CircleCI requires that you supply some configuration for processing the requests.

## Authentication

You can configure the token through
`Mix.Config`

```elixir
# config.exs

config :circle_ci,
  token: "12345"
```

Or by setting the environment variable `CIRCLECI_TOKEN`

## Encoding Module

CircleCI will default to using the exjsx json module for encoding / decoding.
You can alter this behaviour by specifying it in the configuration

```elixir
# config.exs

config :circle_ci,
  json_module: Poison
```

# TODO

The following endpoints need to be added

https://circleci.com/docs/api/v1-reference/#new-build-branch
https://circleci.com/docs/api/v1-reference/#new-build
https://circleci.com/docs/api/v1-reference/#add-user-ssh
https://circleci.com/docs/api/v1-reference/#build-artifacts-latest
