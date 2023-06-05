### `chmod`

- `chmod 644`: The owner can read and write the file but not execute it. The file's group and everyone else can only read the file. This is a common value for files you want to be readable by everyone, but only changeable by the owner, like configuration files.

- `chmod 755`: The owner can read, write, and execute the file. The file's group and everyone else can read and execute the file, but can't change it. This is a common value for directories and for files that are executables, like shell scripts.

- `chmod 600`: The owner can read and write the file, but can't execute it. Nobody else can do anything with the file. This is a common value for files that contain sensitive information, like private SSH keys.

- `chmod 700`: The owner can read, write, and execute the file. Nobody else can do anything with the file. This is a common value for directories that contain sensitive files.

- `chmod 777`: Everyone can do everything: read, write, execute. This is potentially very dangerous and should be avoided whenever possible, as it allows any user to change or delete the file.

### `chown`

- `chown username:groupname filename`: Changes the owner and group of the file or directory to `username` and `groupname` respectively.

- `chown username: filename`: Changes the owner of the file to `username`. The group to `username`.

- `chown username filename`: Changes the owner of the file to `username`. The group will not be changed.

- `chown :groupname filename`: Changes the group of the file to `groupname`. The owner will not be changed.
