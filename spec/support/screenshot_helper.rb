module ScreenshotHelper
  def take_screenshot path, options = {}
    sleep 1.0
    page.save_screenshot "screenshots/#{path}.png", options
  end
end
