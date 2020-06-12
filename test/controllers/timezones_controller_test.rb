require 'test_helper'

class TimezonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timezone = timezones(:one)
  end

  test "should get index" do
    get timezones_url
    assert_response :success
  end

  test "should get new" do
    get new_timezone_url
    assert_response :success
  end

  test "should create timezone" do
    assert_difference('Timezone.count') do
      post timezones_url, params: { timezone: { abbr: @timezone.abbr, isdst: @timezone.isdst, offset: @timezone.offset, text: @timezone.text, utc: @timezone.utc, value: @timezone.value } }
    end

    assert_redirected_to timezone_url(Timezone.last)
  end

  test "should show timezone" do
    get timezone_url(@timezone)
    assert_response :success
  end

  test "should get edit" do
    get edit_timezone_url(@timezone)
    assert_response :success
  end

  test "should update timezone" do
    patch timezone_url(@timezone), params: { timezone: { abbr: @timezone.abbr, isdst: @timezone.isdst, offset: @timezone.offset, text: @timezone.text, utc: @timezone.utc, value: @timezone.value } }
    assert_redirected_to timezone_url(@timezone)
  end

  test "should destroy timezone" do
    assert_difference('Timezone.count', -1) do
      delete timezone_url(@timezone)
    end

    assert_redirected_to timezones_url
  end
end
