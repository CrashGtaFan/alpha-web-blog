require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john_doe', email: 'john_doe@gmail.com', 
                        password: 'qazwsx123', password_confirmation: 'qazwsx123',
                        role: :admin)
  end

  test "get new category form and create category" do
    sign_in_as(@user, 'qazwsx123')
    get new_category_path
      assert_template 'categories/new'
      assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test 'invalid category submission results in failure' do
    sign_in_as(@user, 'qazwsx123')
    get new_category_path
      assert_template 'categories/new'
      assert_no_difference 'Category.count', 1 do
      post categories_path, category: {name: ""}
    end
    assert_template 'categories/new'
    assert_select "div.alert"
  end
end
