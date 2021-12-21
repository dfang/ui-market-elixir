defmodule Mix.Tasks.Phx.Gen.Admin do
  @shortdoc "Generates scaffolds for admin"

  @moduledoc """
  Generates scaffolds for admin

      mix phx.gen.admin --no-schema --web admin Accounts User users name:string age:integer

  """
  use Mix.Task

  alias Mix.Phoenix.{Context, Schema}
  alias Mix.Tasks.Phx.Gen

  @doc false
  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise(
        "mix phx.gen.html must be invoked from within your *_web application root directory"
      )
    end

    {context, schema} = Gen.Context.build(args)
    Gen.Context.prompt_for_code_injection(context)

    binding = [context: context, schema: schema, inputs: inputs(schema)]
    paths = Mix.Phoenix.generator_paths()

    prompt_for_conflicts(context)

    context
    |> copy_new_files(paths, binding)
    |> print_shell_instructions()
  end

  defp prompt_for_conflicts(context) do
    context
    |> files_to_be_generated()
    |> Kernel.++(context_files(context))
    |> Mix.Phoenix.prompt_for_conflicts()
  end

  defp context_files(%Context{generate?: true} = context) do
    Gen.Context.files_to_be_generated(context)
  end

  defp context_files(%Context{generate?: false}) do
    []
  end

  @doc false
  def files_to_be_generated(%Context{schema: schema, context_app: context_app}) do
    web_prefix = Mix.Phoenix.web_path(context_app)
    test_prefix = Mix.Phoenix.web_test_path(context_app)
    web_path = to_string(schema.web_path)

    [
      {:eex, "controller.ex",
       Path.join([web_prefix, "controllers", web_path, "#{schema.singular}_controller.ex"])},
      {:eex, "edit.html.eex",
       Path.join([web_prefix, "templates", web_path, schema.singular, "edit.html.eex"])},
      {:eex, "form.html.eex",
       Path.join([web_prefix, "templates", web_path, schema.singular, "form.html.eex"])},
      {:eex, "index.html.eex",
       Path.join([web_prefix, "templates", web_path, schema.singular, "index.html.eex"])},
      {:eex, "new.html.eex",
       Path.join([web_prefix, "templates", web_path, schema.singular, "new.html.eex"])},
      {:eex, "show.html.eex",
       Path.join([web_prefix, "templates", web_path, schema.singular, "show.html.eex"])},
      {:eex, "view.ex", Path.join([web_prefix, "views", web_path, "#{schema.singular}_view.ex"])},
      {:eex, "controller_test.exs",
       Path.join([test_prefix, "controllers", web_path, "#{schema.singular}_controller_test.exs"])}
    ]
  end

  @doc false
  def copy_new_files(%Context{} = context, paths, binding) do
    files = files_to_be_generated(context)
    Mix.Phoenix.copy_from(paths, "priv/templates/phx.gen.admin", binding, files)
    if context.generate?, do: Gen.Context.copy_new_files(context, paths, binding)
    context
  end

  @doc false
  def print_shell_instructions(%Context{schema: schema, context_app: ctx_app} = context) do
    if schema.web_namespace do
      Mix.shell().info("""

      Add the resource to your #{schema.web_namespace} :browser scope in #{
        Mix.Phoenix.web_path(ctx_app)
      }/router.ex:

          scope "/#{schema.web_path}", #{
        inspect(Module.concat(context.web_module, schema.web_namespace))
      }, as: :#{schema.web_path} do
            pipe_through :browser
            ...
            resources "/#{schema.plural}", #{inspect(schema.alias)}Controller
          end
      """)
    else
      Mix.shell().info("""

      Add the resource to your browser scope in #{Mix.Phoenix.web_path(ctx_app)}/router.ex:

          resources "/#{schema.plural}", #{inspect(schema.alias)}Controller
      """)
    end

    if context.generate?, do: Gen.Context.print_shell_instructions(context)
  end

  @doc false
  def inputs(%Schema{} = schema) do
    Enum.map(schema.attrs, fn
      {_, {:references, _}} ->
        {nil, nil, nil}

      {key, :integer} ->
        {label(key), ~s(<%= number_input f, #{inspect(key)} %>), error(key)}

      {key, :float} ->
        {label(key), ~s(<%= number_input f, #{inspect(key)}, step: "any" %>), error(key)}

      {key, :decimal} ->
        {label(key), ~s(<%= number_input f, #{inspect(key)}, step: "any" %>), error(key)}

      {key, :boolean} ->
        {label(key), ~s(<%= checkbox f, #{inspect(key)} %>), error(key)}

      {key, :text} ->
        {label(key), ~s(<%= textarea f, #{inspect(key)} %>), error(key)}

      {key, :date} ->
        {label(key), ~s(<%= date_select f, #{inspect(key)} %>), error(key)}

      {key, :time} ->
        {label(key), ~s(<%= time_select f, #{inspect(key)} %>), error(key)}

      {key, :utc_datetime} ->
        {label(key), ~s(<%= datetime_select f, #{inspect(key)} %>), error(key)}

      {key, :naive_datetime} ->
        {label(key), ~s(<%= datetime_select f, #{inspect(key)} %>), error(key)}

      {key, {:array, :integer}} ->
        {label(key), ~s(<%= multiple_select f, #{inspect(key)}, ["1": 1, "2": 2] %>), error(key)}

      {key, {:array, _}} ->
        {label(key),
         ~s(<%= multiple_select f, #{inspect(key)}, ["Option 1": "option1", "Option 2": "option2"] %>),
         error(key)}

      {key, _} ->
        {label(key), ~s(<%= text_input f, #{inspect(key)} %>), error(key)}
    end)
  end

  defp label(key) do
    ~s(<%= label f, #{inspect(key)} %>)
  end

  defp error(field) do
    ~s(<%= error_tag f, #{inspect(field)} %>)
  end
end
