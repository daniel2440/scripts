local lapis = require("lapis")
local json_params = require("lapis.application").json_params
local json_parser = require 'lunajson'
local to_json = require("lapis.util").to_json
local app= lapis.Application()

local products = {}
products[1] = {
  ["name"]="headphones_one_name",
  ["price"]=33,
  ["description"]="headphones_one_description",
  ["category"]="headphones"
}
products[2] = {
  ["name"]="headphones_two_name",
  ["price"]=10,
  ["description"]="headphones_two_description",
  ["category"]="headphones"
}
products[3] = {
  ["name"]="headphones_three_name",
  ["price"]=12,
  ["description"]="headphones_three_description",
  ["category"]="headphones"
}
products[4] = {
  ["name"]="keyboard_one_name",
  ["price"]=122,
  ["description"]="keyboard_one_description",
  ["category"]="keyboard"
}
products[5] = {
  ["name"]="keyboard_two_name",
  ["price"]=222,
  ["description"]="keyboard_two_description",
  ["category"]="keyboard"
}
products[6] = {
  ["name"]="keyboard_three_name",
  ["price"]=212,
  ["description"]="keyboard_three_description",
  ["category"]="keyboard"
}
products[7] = {
  ["name"]="mouse_one_name",
  ["price"]=35,
  ["description"]="mouse_one_description",
  ["category"]="mouse"
}
products[8] = {
  ["name"]="mouse_two_name",
  ["price"]=47,
  ["description"]="mouse_two_description",
  ["category"]="mouse"
}
products[9] = {
  ["name"]="mouse_three_name",
  ["price"]=12,
  ["description"]="mouse_three_description",
  ["category"]="mouse"
}

local categories={}
categories[1]={["name"]="mouse"}
categories[2]={["name"]="headphones"}
categories[3]={["name"]="keyboard"}

app:get("/", json_params(function(self)
  return "Welcome to shop" 
end))

-- get all products
app:get("/products", json_params(function(self)
  local json_products=json_parser.encode(products)
  return json_products
end))

-- get one product with id param
app:get("/products/:id", json_params(function(self)
  return json_parser.encode(products[tonumber(self.params.id)])
end))

--add one product
app:post("/products", json_params(function(self)
  products[#products+1]={
    ["name"]=self.params.name,
    ["price"]=self.params.price,
    ["description"]=self.params.description,
    ["category"]=self.params.category
  }
  return json_parser.encode(products[#products]).." added"
end))

--update one product
app:put("/products/:id", json_params(function(self)
  products[tonumber(self.params.id)]={
    ["name"]=self.params.name,
    ["price"]=self.params.price,
    ["description"]=self.params.description,
    ["category"]=self.params.category
  }
  return "product "..self.params.id.." is now "..json_parser.encode(products[tonumber(self.params.id)])
end))

--delete one product
app:delete("/products/:id", json_params(function(self)
  table.remove(products,tonumber(self.params.id))
  local json_products=json_parser.encode(products)
  -- to show that there is no longer deleted product
  return json_products
end))




--get all categories
app:get("/categories", json_params(function(self)
  local json_categories=json_parser.encode(categories)
  return json_categories
end))

--get one category
app:get("/categories/:id", json_params(function(self)
  return json_parser.encode(categories[tonumber(self.params.id)])
end))

--add one category
app:post("/categories", json_params(function(self)
  categories[#categories+1]={["name"]=self.params.name}
  return json_parser.encode(categories[#categories]).." added"
end))

--update one category
app:put("/categories/:id", json_params(function(self)
  categories[tonumber(self.params.id)]={["name"]=self.params.name}
  return "category "..self.params.id.." is now "..json_parser.encode(categories[tonumber(self.params.id)])
end))

--delete one category
app:delete("/categories/:id", json_params(function(self)
  table.remove(categories,tonumber(self.params.id))
  local json_categories=json_parser.encode(categories)
  return json_categories
end))

return app