OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           '1011017325464-c3grnsjkqkgbecvbji3bka93bej51hbl.apps.googleusercontent.com',
           '1rSLRdu9Rk_T65onxLa5EjQ1',
           client_options: {
             ssl: {
               ca_file: Rails.root.join('cacert.pem').to_s
             }
           }
end
