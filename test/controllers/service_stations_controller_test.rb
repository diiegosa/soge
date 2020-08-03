require 'test_helper'

class ServiceStationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @service_station = service_stations(:one)
  end

  test "should get index" do
    get service_stations_url
    assert_response :success
  end

  test "should get new" do
    get new_service_station_url
    assert_response :success
  end

  test "should create service_station" do
    assert_difference('ServiceStation.count') do
      post service_stations_url, params: { service_station: { acronym: @service_station.acronym, command_post_id: @service_station.command_post_id, description: @service_station.description, event_id: @service_station.event_id, militaries_quantity: @service_station.militaries_quantity, service_station_type_id: @service_station.service_station_type_id, work_shift: @service_station.work_shift } }
    end

    assert_redirected_to service_station_url(ServiceStation.last)
  end

  test "should show service_station" do
    get service_station_url(@service_station)
    assert_response :success
  end

  test "should get edit" do
    get edit_service_station_url(@service_station)
    assert_response :success
  end

  test "should update service_station" do
    patch service_station_url(@service_station), params: { service_station: { acronym: @service_station.acronym, command_post_id: @service_station.command_post_id, description: @service_station.description, event_id: @service_station.event_id, militaries_quantity: @service_station.militaries_quantity, service_station_type_id: @service_station.service_station_type_id, work_shift: @service_station.work_shift } }
    assert_redirected_to service_station_url(@service_station)
  end

  test "should destroy service_station" do
    assert_difference('ServiceStation.count', -1) do
      delete service_station_url(@service_station)
    end

    assert_redirected_to service_stations_url
  end
end
