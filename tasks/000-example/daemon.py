#!/usr/bin/python3
import socket

listen_port = 8080

def main(p: int):
    s = socket.socket()
    s.bind(('0.0.0.0', p))
    s.listen()
    
    (clientSock, clientAddr) = s.accept()
    while True:
        data =  clientSock.recv(1024)
        if data != b'':
            clientSock.sendall(str.encode('echo {}'.format(data)))

if __name__ == '__main__':
    print('Daemon will listen on port {}.'.format(listen_port))
    main(listen_port)