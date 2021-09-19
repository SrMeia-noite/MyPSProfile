# Functions from other projects of mine.
function getRGBSineOf($n, $frequency = .1, $waveCenter = 128, $waveWidth = 127, $rPhase = 0, $gPhase = 2, $bPhase = 4)
{
    $r = [int][Math]::Round([Math]::Sin($frequency * $n + $rPhase) * $waveWidth + $waveCenter)
    $g = [int][Math]::Round([Math]::Sin($frequency * $n + $gPhase) * $waveWidth + $waveCenter)
    $b = [int][Math]::Round([Math]::Sin($frequency * $n + $bPhase) * $waveWidth + $waveCenter)

    return ($r, $g, $b)
}

function RGBpaint($string, $rgb) 
{
    $r, $g, $b = $rgb; $esc = [char]27; return "${esc}[38;2;${r};${g};${b}m${string}${esc}[00m"
}

function rainbowPrint($string, $cache = 1)
{
    $newString = ""
    for ($n = 0; $n -lt $string.Length; ++$n)
    {
        $newString += RGBpaint $string[$n] (getRGBSineOf($n + $cache))
    }
    
    Write-Host -NoNewLine $newString
}

# Main Prompt
Clear-Host

$global:LOL       = 0
$global:rgbCache  = 1
$global:increment = 2
$global:limit     = 500

function Prompt
{
    if ($LOL -eq 1)
    {
        $global:rgbCache = (($global:rgbCache + $global:increment), 1)[$global:rgbCache -gt $global:limit]
        rainbowPrint "(${env:USERNAME}?${env:COMPUTERNAME}) [$(Get-Location)]$" $global:rgbCache
        return " "
    }

    Write-Host -NoNewLine "("                 -foregroundColor "white"
    Write-Host -NoNewLine "$env:USERNAME"     -foregroundColor "red"
    Write-Host -NoNewLine "?"                 -foregroundColor "white"
    Write-Host -NoNewLine "$env:COMPUTERNAME" -foregroundColor "magenta"
    Write-Host -NoNewLine ") "                -foregroundColor "white"
    Write-Host -NoNewLine "["                 -foregroundColor "white"
    Write-Host -NoNewLine (get-location)      -foregroundColor "yellow"
    Write-Host -NoNewLine "]"                 -foregroundColor "white"
    Write-Host -NoNewLine "$"                 -foregroundColor "white"
    return " "
}
