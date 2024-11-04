=> ERROR [2/3] RUN apt-get update &&     apt-get install -y unzip curl python3-pip &&     pip3 install awscli --upgrade                  0.3s
------                                                                                                                                         
 > [2/3] RUN apt-get update &&     apt-get install -y unzip curl python3-pip &&     pip3 install awscli --upgrade:
0.259 Reading package lists...
0.269 E: List directory /var/lib/apt/lists/partial is missing. - Acquire (13: Permission denied)
------
Dockerfile:5
--------------------
   4 |     # Install required packages
   5 | >>> RUN apt-get update && \
   6 | >>>     apt-get install -y unzip curl python3-pip && \
   7 | >>>     pip3 install awscli --upgrade
   8 |     
--------------------
ERROR: failed to solve: process "/bin/sh -c apt-get update &&     apt-get install -y unzip curl python3-pip &&     pip3 install awscli --upgrade" did not complete successfully: exit code: 100
root@ip-172-31-24-46:/home/ubuntu/aws-cli-project# ^C
root@ip-172-31-24-46:/home/ubuntu/aws-cli-project# vi Dockerfile 
root@ip-172-31-24-46:/home/ubuntu/aws-cli-project# docker build -t aws-image .
[+] Building 0.1s (1/1) FINISHED                                                                                                docker:default
 => [internal] load build definition from Dockerfile                                                                                      0.0s
 => => transferring dockerfile: 1.07kB                                                                                                    0.0s
Dockerfile:8
--------------------
   6 |         apt-get install -y --no-install-recommends \
   7 |             unzip \                        # Required for extracting files
   8 | >>>         curl \                         # Required for downloading files
   9 |             python3 \                     # Required to install pip
  10 |             python3-pip &&                # Package manager for Python
--------------------
ERROR: failed to solve: dockerfile parse error on line 8: unknown instruction: curl
