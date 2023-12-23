import os
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

# Get the absolute path to the home directory
home_dir = os.path.expanduser('~')

# Create an authorizer with a user
authorizer = DummyAuthorizer()
authorizer.add_user("ftpuser", "password", os.path.join(home_dir, "your-dir"), perm="elradfmw")

# Create an FTP handler and bind it to the authorizer
handler = FTPHandler
handler.authorizer = authorizer

# Start the FTP server on localhost and port 8090
server = FTPServer(("localhost", 8090), handler)

# Start the server
server.serve_forever()

##start ftp server via python in your-dir
