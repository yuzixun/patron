require 'rubygems'
require 'patron'
class HttpClient
  attr_accessor :body, :cookieString, :cookieArray, :status, :headers

  def get(url)
    sess = Patron::Session.new
    resp = sess.get(url)
    setResult resp
  end

  def getWithCookie(url, cookie)
    sess = Patron::Session.new
    sess.headers['cookie']=cookie
    resp = sess.get(url)
    setResult resp
  end

  def postWithCookie(url,data,cookie)
    sess = Patron::Session.new
    sess.headers['cookie']=cookie
    resp = sess.post(url,data)
    setResult resp
  end

  def setResult(resp)
    @status = resp.status
    @headers = resp.headers
    @body = resp.body
    @cookieArray = {}
    if resp.headers['Set-Cookie'].class == Array
      resp.headers['Set-Cookie'].each { |s| /([\s\S]*?)=([\s\S]*?);/.match(s);@cookieArray.store($1,$2) }
    elsif resp.headers['Set-Cookie'].class == String
      resp.headers['Set-Cookie'].each_line { |s| /([\s\S]*?)=([\s\S]*?);/.match(s);@cookieArray.store($1,$2);}
    end

    @cookieString = ''
    @cookieArray.each_pair {|k,v| @cookieString = @cookieString + k+'='+v+';'}
  end

  def get_value key,string
    reg = /#{key}=([\s\S]*?);/
    reg.match string
    $1
  end
end