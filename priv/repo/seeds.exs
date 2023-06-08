# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
 alias Rockelivery.{Item, Order, Repo, User}

 user = %User{
  age: 34,
  address: "Praça da Sé",
  cep: "01001000",
  cpf: "01234567890",
  email: "anderson@email.com",
  password: "123456",
  name: "Anderson Nunes"
 }

 %User{id: user_id} = Repo.insert!(user)

 item1 = %Item{
  category: :food,
  description: "Yakissoba",
  price: Decimal.new("30.00"),
  photo: "priv/photos/yakissoba.png"
 }

 item2 = %Item{
  category: :drink,
  description: "Suco de uva",
  price: Decimal.new("9.50"),
  photo: "priv/photos/suco_uva.png"
 }

 Repo.insert!(item1)
 Repo.insert!(item2)

 order = %Order{
  user_id: user_id,
  items: [item1, item1, item2],
  address: "Avenida Paulista",
  comments: "Sem açucar no suco",
  payment_method: :money
 }

 Repo.insert!(order)
