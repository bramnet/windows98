# DESCRIPTION:	  Run Windows 98 in a container
# AUTHOR:		  Paul DeCarlo <toolboc@gmail.com>
#
#   Made possible through prior art by:
#   copy (v86 - x86 virtualization in JavaScript) 
#   felixrieseberg (Windows98 running in electron) 
#   Microsoft (Windows 98)
#
#   ***Docker Run Command***
#
#   docker run -it \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#    -e DISPLAY=unix$DISPLAY \ # pass the display
#    --device /dev/snd \ # sound
#    --name windows98 \
#    toolboc/windows98
#
#   ***TroubleShooting***
#   If you receive Gtk-WARNING **: cannot open display: unix:0
#   Run:
#       xhost +
#

FROM node:15-stretch

LABEL maintainer "Paul DeCarlo <toolboc@gmail.com>"

RUN apt update && apt install -y \
    libgtk-3-0 \
    libcanberra-gtk3-module \
    libx11-xcb-dev \
    libgconf2-dev \
    libnss3 \
    libasound2 \
    libxtst-dev \
    libxss1 \
    python3>=3.6 \
    git \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN npm install 

ENTRYPOINT [ "npm", "start"]
