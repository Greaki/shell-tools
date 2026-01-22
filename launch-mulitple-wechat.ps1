# 多开微信
$wechatPath = "C:\Program Files\Tencent\Weixin\Weixin.exe"

Start-Process $wechatPath
Start-Sleep -Milliseconds 300
Start-Process $wechatPath
