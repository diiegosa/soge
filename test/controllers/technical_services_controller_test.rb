require 'test_helper'

class TechnicalServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @technical_service = technical_services(:one)
  end

  test "should get index" do
    get technical_services_url
    assert_response :success
  end

  test "should get new" do
    get new_technical_service_url
    assert_response :success
  end

  test "should create technical_service" do
    assert_difference('TechnicalService.count') do
      post technical_services_url, params: { technical_service: { answerable_registry: @technical_service.answerable_registry, final_time: @technical_service.final_time, start_time: @technical_service.start_time, technical_service_id: @technical_service.technical_service_id } }
    end

    assert_redirected_to technical_service_url(TechnicalService.last)
  end

  test "should show technical_service" do
    get technical_service_url(@technical_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_technical_service_url(@technical_service)
    assert_response :success
  end

  test "should update technical_service" do
    patch technical_service_url(@technical_service), params: { technical_service: { answerable_registry: @technical_service.answerable_registry, final_time: @technical_service.final_time, start_time: @technical_service.start_time, technical_service_id: @technical_service.technical_service_id } }
    assert_redirected_to technical_service_url(@technical_service)
  end

  test "should destroy technical_service" do
    assert_difference('TechnicalService.count', -1) do
      delete technical_service_url(@technical_service)
    end

    assert_redirected_to technical_services_url
  end
end
