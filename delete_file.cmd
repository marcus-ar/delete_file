@ECHO OFF

powershell -executionpolicy ByPass ^
    $ar_name = 'delete-file.cmd'; ^
    $log_file = 'C:\Program Files (x86)\ossec-agent\active-response\active-responses.log'; ^
    $rollback = $false; ^
    function Write-Log { ^
        param($message); ^
        $log_line = (Get-Date).ToString('yyyy-MM-dd hh:mm:ss')+' active-response/bin/'+$ar_name+': '; ^
        $log_line += $message; ^
        $log_line ^| Out-File -FilePath $log_file -Append -Encoding ASCII}; ^
    $alert = Read-Host; ^
    $alert_dict = ConvertFrom-Json $alert; ^
    $alert_id = $alert_dict.parameters.alert.id; ^
    $alert_cmd = $alert_dict.command; ^
    $caminho = $alert_dict.parameters.alert.data.win.eventdata.targetFileName; ^
    if (Test-Path $caminho) { ^
        try { ^
            Remove-Item $caminho -Force; ^
            Write-Log ('Active Response - Infomach - Arquivo deletado com sucesso: ' + $caminho) ^
        } ^
        catch { ^
            Write-Log ('Active Response - Infomach - Erro ao deletar o arquivo: ' + $caminho) ^
        } ^
    } ^
    else { ^
        Write-Log ('Active Response - Infomach - Arquivo não encontrado: ' + $caminho) ^
    }; ^
    Write-Log 'Ended'

:Exit
