import socket
from time import sleep

clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
clientsocket.connect(('localhost', 15555))
clientsocket.send(b'Hello, server!')
response = clientsocket.recv(1024)
print(response.decode('utf8'))
#clientsocket.send(b'Hello, server!!!!')


sleep(30)
clientsocket.close()
