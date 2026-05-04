Write-Host "=== OTIMIZACAO TURBO SEM ADMIN ===" -ForegroundColor Cyan

$relatorio = "$env:USERPROFILE\Desktop\relatorio-turbo.txt"
"Relatorio Turbo - $(Get-Date)" | Out-File $relatorio

Write-Host "Fechando programas pesados do usuario..."

$apps = @(
    "chrome",
        "msedge",
            "firefox",
                "teams",
                    "discord",
                        "spotify",
                            "onedrive",
                                "whatsapp",
                                    "telegram",
                                        "zoom"
                                        )

                                        foreach ($app in $apps) {
                                            Get-Process -Name $app -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
                                            }

                                            Write-Host "Limpando TEMP do usuario..."
                                            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando cache de miniaturas..."
                                            Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache_*" -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando cache do Chrome..."
                                            Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Code Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando cache do Edge..."
                                            Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Code Cache\*" -Recurse -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\GPUCache\*" -Recurse -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando cache do Firefox..."
                                            Remove-Item "$env:LOCALAPPDATA\Mozilla\Firefox\Profiles\*\cache2\*" -Recurse -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando downloads temporarios..."
                                            Remove-Item "$env:USERPROFILE\Downloads\*.tmp" -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:USERPROFILE\Downloads\*.crdownload" -Force -ErrorAction SilentlyContinue
                                            Remove-Item "$env:USERPROFILE\Downloads\*.part" -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando logs temporarios do usuario..."
                                            Remove-Item "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

                                            Write-Host "Limpando cache DNS..."
                                            ipconfig /flushdns | Out-Null

                                            Write-Host "Gerando relatorio de processos pesados..."
                                            "=== PROCESSOS MAIS PESADOS POR MEMORIA ===" | Out-File $relatorio -Append
                                            Get-Process |
                                            Sort-Object WorkingSet -Descending |
                                            Select-Object -First 15 Name, Id, @{Name="MemoriaMB";Expression={[math]::Round($_.WorkingSet/1MB,2)}} |
                                            Out-File $relatorio -Append

                                            "=== PROCESSOS MAIS PESADOS POR CPU ===" | Out-File $relatorio -Append
                                            Get-Process |
                                            Sort-Object CPU -Descending |
                                            Select-Object -First 15 Name, Id, CPU |
                                            Out-File $relatorio -Append

                                            Write-Host "Abrindo configuracao de inicializacao..."
                                            Start-Process "taskmgr.exe"

                                            Write-Host ""
                                            Write-Host "=== FINALIZADO ===" -ForegroundColor Green
                                            Write-Host "Relatorio salvo na area de trabalho: relatorio-turbo.txt"
                                            Write-Host "Reinicie o computador depois."