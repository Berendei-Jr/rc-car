import socket
import logging
from threading import Thread
from time import sleep

IP_ADDRESS = '192.168.1.73'
PORT = 15556
BLOCK_LENGTH = 1024


class Server:
    def __init__(self):
        self.logger = logging.getLogger('Server')
        self.logger.info('Starting server...')
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind((IP_ADDRESS, PORT))
        self.socket.listen()
        self.thread = Thread(target=self.run_server, args=())
        self.thread.daemon = True

    def run_server(self):
        while True:
            self.logger.info('Waiting for client...')
            connection, address = self.socket.accept()
            self.logger.info('Client connected: ' + str(address))
            request = None
            while request != 'quit':
                try:
                    request = connection.recv(BLOCK_LENGTH).decode()
                    self.logger.debug('Message from client: ' + request)
                    response = 'Server: ' + request
                    connection.sendall(response.encode())
                except Exception as e:
                    self.logger.error(e)
                    break
            connection.close()
            self.logger.info('Client disconnected: ' + str(address))

    def start(self):
        self.thread.start()

    def stop(self):
        self.socket.close()
        self.thread.join()


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s\t[%(name)s] %(message)s',
                        datefmt='%H:%M:%S')
    server = Server()
    server.start()

    while True:
        sleep(5)
        logging.info('Some work...')
