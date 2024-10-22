Set-Alias vim "C:\Users\Roman.Hanmamedov\Documents\Vim\vim91\vim.exe"
Set-Alias git "C:\Users\Roman.Hanmamedov\AppData\Local\Programs\Git\bin\git.exe"

# Linux functions
function touch($file) { "" | Out-File $file -Encoding ASCII }

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function head {
  param($Path, $n = 10)
  Get-Content $Path -Head $n
}

function tail {
  param($Path, $n = 10, [switch]$f = $false)
  Get-Content $Path -Tail $n -Wait:$f
}

# Theme stile
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
