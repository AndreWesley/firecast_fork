$ErrorActionPreference='Stop'
$pt='C:\Program Files\Git\mingw64\bin\pdftotext.exe'
$ROOT='C:\Users\awlol\OneDrive\Documents\RPG\Storyteller V20\Vampiro\Vampiro - A Máscara\Books\Vampiro'
$cache="$env:TEMP\wod_books_table"
if(-not (Test-Path $cache)){ New-Item -ItemType Directory $cache | Out-Null }
$books=@{
 core=@{f='vampire the masquerade - 20th anniversary edition.pdf'; off=8; ranges=@(,@(305,345))}
 da  =@{f='_Vampiro V20 - Dark Ages - Livro Base.pdf';             off=1; ranges=@(@(112,145),@(428,452))}
 bh  =@{f='Vampiro V20 - The Black Hand A Guide to the TalMaRahe.pdf'; off=1; ranges=@(@(50,62),@(112,120))}
 lotc=@{f='Vampiro V20 - Lore of the Clans.pdf';                   off=1; ranges=@(,@(48,78))}
 dac =@{f='Vampiro V20 - Dark Ages - Companion.pdf';               off=1; ranges=@(,@(66,92))}
}
foreach($k in $books.Keys){
  $e=$books[$k]; $pdf=Join-Path $ROOT $e.f
  if(-not (Test-Path -LiteralPath $pdf)){ Write-Host "MISSING $k -> $pdf"; continue }
  foreach($r in $e.ranges){
    if($r -isnot [array] -or $r.Count -ne 2){ throw "range unrolled for $k" }
    $fp=$r[0]+$e.off; $lp=$r[1]+$e.off
    $out=Join-Path $cache ("{0}_{1}-{2}.txt" -f $k,$r[0],$r[1])
    & $pt -table -enc UTF-8 -f $fp -l $lp $pdf $out | Out-Null
    Write-Host ("{0} printed {1}-{2} (pdf {3}-{4}) -> {5} bytes" -f $k,$r[0],$r[1],$fp,$lp,(Get-Item $out).Length)
  }
}