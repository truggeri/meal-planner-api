class HealthController < ApplicationController
  get "/healthz" do
    [200, "healthy"]
  end
end