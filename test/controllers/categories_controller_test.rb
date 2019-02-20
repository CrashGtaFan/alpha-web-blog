require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: 'john_doe', email: 'john_doe@gmail.com', 
                        password: 'qazwsx123', password_confirmation: 'qazwsx123',
                        role: :admin)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, 'qazwsx123')
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end
  
  test 'should redirect create when admin is not authentificated' do
    assert_no_difference 'Category.count' do
      post :create, category: { name: 'sports' }
    end
    assert_redirected_to categories_path
  end
end
