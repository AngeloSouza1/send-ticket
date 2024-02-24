require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get send_ticket" do
    get students_send_ticket_url
    assert_response :success
  end
end
