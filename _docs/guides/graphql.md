# Graphql API with elixir and phoenix

add to mix.exs

```
# GraphQL API Support
{:absinthe, "~> 1.4"},
{:absinthe_plug, "~> 1.4"},
{:dataloader, "~> 1.0.0"},
{:absinthe_gen, "~> 0.2"},
```


```
# https://fullstackphoenix.com/tutorials/getting-started-with-graphql-and-absinthe-in-phoenix
# create file schema.ex, schema and resolvers folder 
touch lib/graphql_tutorial_web/schema.ex
mkdir lib/graphql_tutorial_web/schema
mkdir lib/graphql_tutorial_web/resolvers

or you can generate them use absinthe_gen

mix help | grep absinthe
mix help absinthe.gen.scaffold
mix absinthe.gen.scaffold my_context my_type my_field:string my_other_field:string
```


add to router.ex

```
scope "/graphql" do
    pipe_through :api

    forward "/", Absinthe.Plug, schema: PragmaticWeb.Schema
  end

  if Mix.env == :dev do
    forward "/graphiql", 
      Absinthe.Plug.GraphiQL,
      schema: PragmaticWeb.Schema
      # interface: :simple
      # context: %{pubsub: PragmaticWeb.Endpoint}
  end
```

open `http://localhost:4000/graphiql`


`Schemas (typeDefs), Resolvers, Query and Mutation.`


### links
- https://pragmaticstudio.com/unpacked-full-stack-graphql-with-absinthe-phoenix-react
