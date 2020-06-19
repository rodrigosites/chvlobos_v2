require 'test_helper'

class ProfessoresControllerTest < ActionDispatch::IntegrationTest
  test "should get model" do
    get professores_model_url
    assert_response :success
  end

  test "should get Professor" do
    get professores_Professor_url
    assert_response :success
  end

end
