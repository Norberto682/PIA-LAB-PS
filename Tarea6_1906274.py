#Se importa los modulos necesarios previamente instalados en cmd como pip install python-nmap
import nmap
#Se realiza el inicio y limite de los puertos a escanear
begin=10
end=40
#Se define la ip o maquina a escanear
target='192.168.0.1'
#Se procede a realizar el proceso de escaneo
scanner=nmap.PortScanner()
for i in range(begin,end+1):
 res = scanner.scan(target,str(i))
 res=res['scan'][target]['tcp'][i]['state']
 print(f'port {i} is {res}.')
