crumb :root do
  link "FURIMA", root_path
end

crumb :profile do
  link "マイページ", profile_path(current_user)
  parent :root
end

crumb :logout do
  link "ログアウト", logout_profiles_path
  parent :profile
end

crumb :cardshow do
  link "登録カード情報", card_path
  parent :profile
end

crumb :CardNew do
  link "カード登録", card_path(current_user)
  parent :profile
end

crumb :items do
  link "商品情報", item_path,@item
  parent :root
end

crumb :category do
  link "カテゴリー一覧", categories_index_items_path
end

crumb :category_parent do |par|
  par = Category.all.find(params[:id])
  link par.name, categories_item_path(par.id)
  parent :category
end