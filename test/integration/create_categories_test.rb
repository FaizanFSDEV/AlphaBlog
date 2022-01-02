require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

 def setup
    @user = User.create(username: "Juvi", email: 'juvi@gmail.com', password: 'juvi123', admin: 'true')
 end

 test "get new category form and create category" do
     sign_in_as(@user,'juvi123')
     get new_category_path
     assert_template 'categories/new'
     assert_difference 'Category.count', 1 do
         post categories_path, params: {category: {name: 'sports'}}
         follow_redirect!
     end
     assert_template 'categories/index'
     assert_match 'sports', response.body
 end

 test "invalid category submission results failure" do
    sign_in_as(@user,'juvi123')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
        post categories_path, params: {category: {name: ''}}
    end
    assert_template 'categories/new'
    assert_select 'h2'
    assert_select 'ul'
 end

 

end
