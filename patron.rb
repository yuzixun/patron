require "./http_client.rb"

httpclient = HttpClient.new
httpclient.get 'http://www.baidu.com'

baidu_id = httpclient.get_value "BAIDUID", httpclient.cookieString

httpclient.getWithCookie('https://passport.baidu.com/v2/api/?getapi&class=login&tpl=mn&tangram=true', 'BAIDUID='+baidu_id.to_s+';HOSUPPORT=1;')

token = /login_token='([\s\S]*?)';/.match(httpclient.body)[1]

httpclient.getWithCookie("https://passport.baidu.com/v2/api/?loginhistory&token=" + token + "&tpl=mn&apiver=v3&tt=" + Time.now.to_i.to_s + "&callback=bd__cbs__vehc6w", 'BAIDUID='+baidu_id.to_s+';HOSUPPORT=1;')
ubi = httpclient.cookieArray['UBI']
passid = httpclient.cookieArray['PASSID']


data = {
	'apiver' => 'v3',
	'callback' => 'parent.bd__pcbs__k2eobr',
	'charset' => 'utf-8',
	'codestring' => '',
	'isPhone' => '',
	'loginmerge' => 'true',
	'logintype' => 'dialogLogin',
	'logLoginType' => 'pc_loginDialog',
	'mem_pass' => 'on',
	'password' => password,
	'ppui_logintime' => '19682',
	'quick_user' => '0',
	'safeflg' => '0',
	'splogin' => 'rate',
	'staticpage' => 'http://www.baidu.com/cache/user/html/v3Jump.html',
	'token' => token,
	'tpl' => 'mn',
	'tt' => Time.now.to_i.to_s,
	'u' => 'http://www.baidu.com/',
	'username' => Username,
	'verifycode' => ''
}
httpclient.postWithCookie('https://passport.baidu.com/v2/api/?login', data, 'BAIDUID='+baidu_id+';HOSUPPORT=1;UBI='+ubi)

if httpclient.body.include?('err_no=0')
	puts "success"
else
	puts "failed"
end
