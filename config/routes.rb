Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "non_res_parses#index"

  get 'citations', to: 'citation_parses#index'
  resource :citation_parse, only: [:show]

  get 'educational', to: 'edu_parses#index'
  resource :edu_parse, only: [:show]

  get 'non_residential', to: 'non_res_parses#index'
  resource :non_res_parse, only: [:show]
end
