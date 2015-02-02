require "Patron"
patron = Patron::Session.new.tap { |session|
  session.base_url = "passport.baidu.com"
  session.insecure = true
  session.username = "yzx8"
  session.password = "523566662yzx"
}

response = patron.get '/v2/api/?getapi&class=login&tpl=mn&tangram=true'
body = response.body

puts body
puts body.to_s.index("bdPass.api.params.login_token")
login_token = body.to_s[127,172-127]

response = patron.post("/v2/api/?login",)




