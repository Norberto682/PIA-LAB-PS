#Se crea el menu para poder escanerar la subred y los puertos ademas de otorgarn la hora y la opcion de salir
Write-host Menú
Write-host ====
Write-host "1) Rango de SubRed y escaneo de IP a desear"
Write-host "2)  Dar la hora"
Write-host "3) Salir"
$opcion = Read-Host
switch($opcion)
{
	1 {$actual;break}
	2 {date;break}
	3 {exit;break}
	default {break}
} 
#Poder determinar el gateway de la red interna, y el rango de la rubred para asi poder establecer una conectividad de la conexion
$subred=(Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
Write-Host "Tu gateway es: "$subred
#En esta parte se determinara el rango de la rubred 
$rango= $subred.Substring(0,$subred.IndexOf('.') + 1 + $subred.Substring($subred.IndexOf('.')+1).IndexOf('.')+3)
echo $rango
$punto = $rango.EndsWith('.')
if ($punto -like "False") 
{
$rango= $rango + '.'
}
$rango_ip= @(1..254)
foreach ($r in $rango_ip)
{
$actual = $rango + $r
$responde= Test-Connection $actual -Quiet -Count 1
if ($responde -eq "True")
{
Write-Output ""
Write-Host "Host responde: " -NoNewline; Write-Host $actual -ForegroundColor Green
}
}
#Ahora veremos el escaneo de puertos en una determinada ip ademas de cuales estan conectados o abiertos #Primero se determina la ip a la cual se va a escanear
ipconfig
try{ $resultado = $TCPObject.ConnectAsync("192.168.1.67",139).Wait(100)}catch{}
echo $resultado
$portstoscan= @(20,21,22,23,25,50,51,53,80,,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5986,8080,10000)
$waittime=100
Write-Host "Direccion ip a escanear: " -NoNewline
$direccion = Read-Host
foreach ($p in $portstoscan)
{
$TCPObject = new-object System.Net.Sockets.TcpClient
try{$resultado = $TCPObject.ConnectAsync($direccion,$p).Wait($waittime)}catch{}
if( $resultado -eq "True")
{
Write-Host "Puerto abierto: " -NoNewline; Write-Host $p -ForegroundColor Green
}
}
