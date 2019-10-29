
$M = @{
    Path       = "miniZ"
    Type       = "NVIDIA"
    Arguments  = @(
        "--server `$(if (`$EnableSSL){'ssl://'})#Server#"
        "--port #Port#"
        "--user #Login#"
        "--pass #Password#"
        "--gpu-line"
        "--extra"
        "--nocolor"
        "--cuda-devices #DevicesETHMode#"
        "--telemetry 0.0.0.0:#APIPort#"
        "#AlgorithmParameters#"
        "#CustomParameters#"
    )
    API        = "MiniZ"
    SSL        = $true
    Fee        = 0.02
    Algorithms = [PSCustomObject]@{
        Equihash96  = @{
            Params = "--par=96,5 --pers auto"
            Mem    = 1.75
        }
        Equihash125 = @{
            Params = "--par=125,4"
        }
        Equihash144 = @{
            Params = "--par=144,5 --pers auto"
            Mem    = 1.75
        }
        Equihash150 = @{
            Params = "--par=150,5"
            Mem    = 2.9
        }
        Equihash192 = @{
            Params = "--par=192,7 --pers auto"
            Mem    = 2.75
        }
        # Equihash210 = @{
        #     Params = "--par=210,9"
        # }
    }
}

if ($SystemInfo.CudaVersion -ge [version]"10.0") {
    $M.Uri = "https://github.com/yuzi-co/miners-linux/releases/download/2019.09/miniZ_v1.5q5_cuda10_linux-x64.tar.gz"
    $M.SHA256 = "E25AB2398285924DBCE749CB89E5D0A69102DA7B2C6ADFF226CFBE593A7C6961"
    $M.CUDA = 10
} elseif ($SystemInfo.CudaVersion -ge [version]"8.0") {
    $M.Uri = "https://github.com/yuzi-co/miners-linux/releases/download/2019.09/miniZ_v1.5q5_linux-x64.tar.gz"
    $M.SHA256 = "5B77EA1ACE4C36ACDCDA810769A659A781696EEDC78E7B9F39FB2BB88DA8B2FE"
    $M.CUDA = 8.0
} else {
    return
}

return [PSCustomObject]$M