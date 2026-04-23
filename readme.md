## 基于powershell的实用小脚本

- 自动检测wifi连接情况并重连
- 双开微信等
- 根据端口号杀死进程


### 这些脚本如果使用**.ps1 执行的话有点繁琐，所以最好可以写到$PROFILE 中（以powershell为例）

```ps1

function killport {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$Port
    )
    $script = es -n 1 kill-port.ps1
    if ($script) {
        & $script -Port $Port
    } else {
        Write-Host "未找到 kill-port.ps1 文件" -ForegroundColor Red
    }
}


function wechat {
    $script = es -n 1 launch-mulitple-wechat.ps1
    if ($script) {
    & $script
    } else {
    Write-Host "未找到 launch-mulitple-wechat.ps1 文件" -ForegroundColor Red
    }
}


```

### 使用的时候
```shell
killport 8000 # 杀死8000端口占用的进程
wechat # 双开微信
```


### 注意事项
- 最好电脑安装一下es（everything search）window中搜索文件非常快
- 