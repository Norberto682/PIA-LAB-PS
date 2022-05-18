from tkinter import *
from tkinter.ttk import*
#Se importa tambien el metodo para obtener la hora deseada
from time import strftime

root = Tk()
root.title('Reloj')
def hora():
 datos= strftime('%I:%M:%S %p')
 label.config(text = datos)
 label.after(1000, hora)
#Estilo personalizable del reloj 
label=Label(root,
 font= (
     'Arial', 80
 ),
 padding='60',
 background= 'blue',
 foreground= 'white'
)
#Se mueve el reloj al centro de la pantalla
label.pack(expand=True)
hora()
mainloop()