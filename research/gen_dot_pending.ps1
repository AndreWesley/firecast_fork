# gen_dot_pending.ps1 - SPEC T1042 / I163g / V480a / R164.
#
# Gera a arte da bolinha PENDENTE (comprada & ainda nao aplicada) a partir da arte
# ON de cada era. R164 mediu que cada prime_on_*.png e um disco de COR UNICA com a
# borda so em alpha, entao recolorir e trocar o RGB e PRESERVAR o A, pixel a pixel:
# zero decisao de forma, so de cor.
#
# As 3 cores sao a resposta de Q83.1 - a MESMA matiz da era com metade da luz, para
# nao nascer matiz nova (V53). Trocar a cor pendente e trocar UMA linha aqui.

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$MAP = @(
    @{ src = 'prime_on_crimson.png'; dst = 'prime_on_pending_crimson.png'; hex = '7A2E3A' },
    @{ src = 'prime_on_gold.png';    dst = 'prime_on_pending_gold.png';    hex = '7A6636' },
    @{ src = 'prime_on_silver.png';  dst = 'prime_on_pending_silver.png';  hex = '6E747A' }
)

$dir = Join-Path $PSScriptRoot '..\Plugins\Sheets\World of Darkness 20th Anniversary Edition\WoD20th\images'
$dir = (Resolve-Path $dir).Path

foreach ($m in $MAP) {
    $srcPath = Join-Path $dir $m.src
    $dstPath = Join-Path $dir $m.dst

    if (-not (Test-Path $srcPath)) { throw ('missing source art: ' + $srcPath) }

    $r = [Convert]::ToInt32($m.hex.Substring(0, 2), 16)
    $g = [Convert]::ToInt32($m.hex.Substring(2, 2), 16)
    $b = [Convert]::ToInt32($m.hex.Substring(4, 2), 16)

    $src = [System.Drawing.Bitmap]::FromFile($srcPath)
    $out = New-Object System.Drawing.Bitmap($src.Width, $src.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

    for ($y = 0; $y -lt $src.Height; $y++) {
        for ($x = 0; $x -lt $src.Width; $x++) {
            # So o alpha do original sobrevive - o RGB inteiro vira a cor pendente.
            $a = $src.GetPixel($x, $y).A
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($a, $r, $g, $b))
        }
    }

    $src.Dispose()
    $out.Save($dstPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $out.Dispose()

    # A prova que T1042 pede: centro opaco na cor pedida, borda na MESMA cor com A < 255.
    $chk = [System.Drawing.Bitmap]::FromFile($dstPath)
    $c = $chk.GetPixel([int]($chk.Width / 2), [int]($chk.Height / 2))
    $e = $chk.GetPixel([int]($chk.Width / 2), 0)
    Write-Host ('{0}  {1}x{2}  centro=#{3:X2}{4:X2}{5:X2} A={6}  topo A={7}' -f $m.dst, $chk.Width, $chk.Height, $c.R, $c.G, $c.B, $c.A, $e.A)
    $chk.Dispose()
}
