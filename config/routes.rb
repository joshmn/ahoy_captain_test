class AhoyCaptain::ApplicationController
  def track_ahoy_visit
    if params[:page] && request.variant.include?(:details)
      ahoy.track("$details_paginate", params)
      return
    end

    if request.variant.include?(:details)
      ahoy.track("$details", params)
      return
    end
    return unless request.format.html?
    return if request.headers['Turbo-Frame']

    ahoy.track("$view", params)

    if request.path != "/"
      ahoy.track("$clicked_something", params)
    end

    if request.path.include?("/filters")
      ahoy.track("$filter", params)
    end

    if params[:period].present?
      ahoy.track("$changed_period", params)
    end

    if params[:start_date].present?
      ahoy.track("$custom_date", params)
    end
  end
end

Rails.application.routes.draw do
  mount AhoyCaptain::Engine => '/'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
