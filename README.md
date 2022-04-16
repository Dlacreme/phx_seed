# Phoenix Seed

A simple Phoenix Seed. It includes:
 - clean split APP / API
 - Authentication for APP and API
 - Entity setup for users
 - Mailer setup with Mailgun and HTML templates
 - front-end stack: typescript, scss, tailwind (built with eslint)
 - colors relying on scss variables
 - material icons
 - Many HTML helpers + basics components
 - code analyzers
 - money

## Deployment

I've deployed such seed on clever cloud without any problems. See more information: https://blog.kalvad.com/deploy-phoenix-application-clevercloud/

## Guideline

## Payment

### Dealing with Money

We are using `money` to store and deal with amount of money. Please read the documentation: https://github.com/elixirmoney/money

To add a Money field:
 - migration `add :price, :money_with_currency`
 - schema `field :price, Money.Ecto.Composite.Type`
 - usage: `price = Money.new(100, :USD)`


### Front-end

Our app is fully configured with `eslint`. All the JS/CSS pipeline are available in `config/config.exs` and the watchers are setup in `config/dev.exs`

 - We are using `typescript` only. The code is located in `assets/app`.
 - We use `tailwind` as our main css framework. Make sure to read the following section to properly split your HTML templates and avoid messy class duplicates.
 - We have a `scss` pipeline setup if tailwind is not enough. You can find the code in `assets/css`

### Templates architecture

We want to keep our templates small & easy to read/edit. To do so, we are building reusable components as much as possible.
To do so, we rely on 2 cool Phoenix's features:

 - helpers: for writing very small HTML element (such as buttons, icons, etc..)
 - components: for building more complex and dynamic elements

#### Html Helpers

All Helpers are available `lib/to_replace_web/helpers`. You can then use it in any templates by calling:

```html
<div>
<%= Helpers.YourHelper.render_stuff hello: "world" %>
</div>
```

*Note we have an alias `to_replaceWeb.Helpers` in `to_replace_web`. So your module must be named `to_replaceWeb.Helpers.YourHelper`*

#### Phoenix Components

All components must be in `lib/to_replace_web/components`. We suggest you read the documentation https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html

Once created, you can use your component:

```html
<.cool_component name="hello" params={params}>
</.cool_component>
```

Component can also host HTML:
```html
<.cool_component_with_content>
    <p>this can be rendered by using `<%= render_slot(@inner_block) %>` in the component</p>
</.cool_component_with_content>
```

*Note: if you add your own component, make sure to import it in `lib/to_replace_web.ex#101`.*


### Useful links

  * Phoenix Docs: https://hexdocs.pm/phoenix
  * Phoenix Forum: https://elixirforum.com/c/phoenix-forum
  * Tailwind doc: https://tailwindcss.com/docs/
  * List of material icons: https://fonts.google.com/icons?selected=Material+Icons


### !! HOW TO USE THIS SEED

Replace (case sensitive):
 - ToReplace -> YourApp         (modules)
 - to_replace -> your_app       (html)
 - toreplace -> yourapp         (otp)