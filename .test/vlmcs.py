from os import system as cs
from random import randint

import time

### 
# TEST MODE
#
# AS_TIME is running in the time in seconds (terminate after seconds)
# AS_REQS is running based on the number of maximum request (terminate after requests)
#
# NOTE!
# Only one of them can be configured. If both enabled, the test case will not run.
###

AS_TIME = False
MAX_TIME = 60

AS_REQS = True
MAX_REQ = 1000000000

# Define where the vlmcs binary should be executed
VLMCS_BIN = "../bin/vlmcs"

# Target Host and Port
HOST = ""
PORT = ""

# Set to TRUE if want to logging verbose
IS_VERBOSE = False

# Let vlmcs pretends to be a client running on VM
IS_VM = False

# Custom APP GUID, KMS GUID, CLI GUID, AND WORKSTATION NAME
CUSTOM_APP_GUID = ""
CUSTOM_KMS_GUID = ""
CUSTOM_CLI_GUID = ""
CUSTOM_WKS_NAME = ""

# Maximum client app ID. See in your `vlmcsd -x`
MAX_APP_ID = 252

ARG = ""

def running_as_time():
    start_time = time.time()
    end_time = start_time + MAX_TIME
    count = 0
    while(time.time() < end_time):
        print(f"Request number: {count}")
        cs(f"{VLMCS_BIN} -l {randint(1, MAX_APP_ID)} {ARG}")
        
def running_as_reqs():
    for i in range(1, MAX_REQ + 1):
        print(f"Request number: {i}")
        cs(f"{VLMCS_BIN} -l {randint(1, MAX_APP_ID)} {ARG}")

if __name__ == "__main__":
    
    if (AS_TIME and AS_REQS) or ((not AS_TIME) and (not AS_REQS)):
        print("Invalid configuration")
        exit(1)
    
    if len(VLMCS_BIN) == 0:
        print("VLMCS_BIN is not set. Please set it to the path of the VLMCS binary.")
        exit(1)
    
    if len(HOST) == 0:
        ARG = f"localhost"
    else:
        ARG = f"{HOST}"
    
    if len(PORT) == 0:
        ARG = f"{ARG}:1688"
    else:
        ARG = f"{ARG}:{PORT}"
    
    if IS_VERBOSE:
        ARG = f"{ARG} -v"
    
    if IS_VM:
        ARG = f"{ARG} -m"
    
    if len(CUSTOM_APP_GUID) != 0:
        ARG += f" -a {CUSTOM_APP_GUID} "
    
    if len(CUSTOM_KMS_GUID) != 0:
        ARG += f" -k {CUSTOM_APP_GUID} "
        
    if len(CUSTOM_CLI_GUID) != 0:
        ARG += f" -c {CUSTOM_CLI_GUID} "
    
    if len(CUSTOM_WKS_NAME) != 0:
        ARG += f" -w {CUSTOM_WKS_NAME} "
    
    if (AS_TIME):
        running_as_time()
    
    if (AS_REQS):
        running_as_reqs()