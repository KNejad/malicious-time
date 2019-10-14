if ENV["DEPLOY_ADDRESS"]
  server ENV["DEPLOY_ADDRESS"], user: "deploy", roles: %w{web app db}
else
  server "time.keeyan.xyz", user: "deploy", roles: %w{web app db}
end

set :application, "time.keeyan.xyz"
