#!/bin/bash

NODE1="Node1"
NODE2="Node2"
CONTAINER="ping_pong"
IM_NAME="pp_image"
TAR_FILE="/tmp/pp.tar"

ACTIVE_NODE=$NODE1
INACTIVE_NODE=$NODE2

while true; do
    echo "Starting container on $ACTIVE_NODE"
    vagrant ssh $ACTIVE_NODE -c "
        docker rm -f $CONTAINER >/dev/null 2>&1 || true
        docker run -d --name $CONTAINER -p 8080:80 ealen/echo-server
    "

    echo "Container running on $ACTIVE_NODE. Waiting 60 seconds..."
    sleep 60

    echo "Committing and saving container from $ACTIVE_NODE..."
    vagrant ssh $ACTIVE_NODE -c "
        CID=\$(docker ps -qf name=$CONTAINER)
        if [ -n \"\$CID\" ]; then
            sudo docker commit \$CID $IM_NAME
            sudo docker save -o $TAR_FILE $IM_NAME
        fi
    "

    echo "Copying image from $ACTIVE_NODE to $INACTIVE_NODE..."
    vagrant ssh $ACTIVE_NODE -c "sudo cp $TAR_FILE /vagrant/pp.tar"
    vagrant ssh $INACTIVE_NODE -c "sudo cp /vagrant/pp.tar $TAR_FILE"

    echo "Loading image and starting container on $INACTIVE_NODE..."
    vagrant ssh $INACTIVE_NODE -c "
        sudo chmod 644 $TAR_FILE || true
        sudo docker load -i $TAR_FILE
        sudo docker rm -f $CONTAINER >/dev/null 2>&1 || true
        sudo docker run -d --name $CONTAINER -p 8080:80 $IM_NAME
    "

    echo "Cleaning up $ACTIVE_NODE..."
    vagrant ssh $ACTIVE_NODE -c "
        sudo rm -f $TAR_FILE
        docker rm -f $CONTAINER >/dev/null 2>&1 || true
        rm -f /vagrant/pp.tar || true
    "


    echo "Migration completed: $ACTIVE_NODE to $INACTIVE_NODE"

    TMP=$ACTIVE_NODE
    ACTIVE_NODE=$INACTIVE_NODE
    INACTIVE_NODE=$TMP

    echo "Let's do this again."
done
