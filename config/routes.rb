Hfinder::Application.routes.draw do
  post '/nearbys' => 'locations#nearbys'
  root to: "locations#index"
end
