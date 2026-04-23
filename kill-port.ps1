param(
    [Parameter(Mandatory = $true)]
    [int]$Port
)

# 端口范围校验
if ($Port -lt 1 -or $Port -gt 65535) {
    Write-Host "端口号无效，请输入 1-65535 之间的数字。" -ForegroundColor Red
    exit 1
}

# 系统关键进程名单（小写），这些进程不允许被杀死
$systemProcesses = @(
    "system", "idle", "smss", "csrss", "wininit", "winlogon",
    "services", "lsass", "lsm", "svchost", "dwm", "ntoskrnl",
    "registry", "memory compression"
)

# 查找占用指定端口的连接
$connections = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue

if (-not $connections) {
    Write-Host "未找到占用端口 $Port 的进程。" -ForegroundColor Yellow
    exit 1
}

# 获取去重后的 PID 列表
$procIds = $connections | Select-Object -ExpandProperty OwningProcess -Unique

foreach ($procId in $procIds) {
    $process = Get-Process -Id $procId -ErrorAction SilentlyContinue

    if (-not $process) {
        Write-Host "PID $procId 对应的进程已不存在，跳过。" -ForegroundColor Yellow
        continue
    }

    $procName = $process.ProcessName.ToLower()

    # 判断是否为系统关键进程
    if ($systemProcesses -contains $procName -or $procId -eq 0 -or $procId -eq 4) {
        Write-Host "端口 $Port 被系统关键进程占用: $($process.ProcessName) (PID: $procId)，拒绝杀死。" -ForegroundColor Red
        continue
    }

    Write-Host "端口 $Port 被进程占用: $($process.ProcessName) (PID: $procId)" -ForegroundColor Cyan
    Write-Host "正在终止进程..." -ForegroundColor Cyan

    try {
        Stop-Process -Id $procId -Force -ErrorAction Stop
        Write-Host "进程已成功终止: $($process.ProcessName) (PID: $procId)" -ForegroundColor Green
    }
    catch {
        Write-Host "终止进程失败: $_" -ForegroundColor Red
    }
}
