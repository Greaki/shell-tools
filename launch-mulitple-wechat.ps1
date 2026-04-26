# 多开微信
$wechatPath = "C:\Program Files\Tencent\Weixin\Weixin.exe"

# $wechatPath = es -n 1 weixin.exe  # 基于everything 搜索最靠谱，不用写死路径
Start-Process $wechatPath
Start-Sleep -Milliseconds 300
Start-Process $wechatPath
