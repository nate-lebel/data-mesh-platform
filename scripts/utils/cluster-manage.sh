#!/bin/bash

case "$1" in
    start)
        docker start $(docker ps -aq --filter "label=io.x-k8s.kind.cluster=data-mesh-dev")
        echo "Cluster started"
        ;;
    stop)
        docker stop $(docker ps -aq --filter "label=io.x-k8s.kind.cluster=data-mesh-dev")
        echo "Cluster stopped"
        ;;
    restart)
        $0 stop
        sleep 5
        $0 start
        ;;
    delete)
        kind delete cluster --name data-mesh-dev
        echo "Cluster deleted"
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|delete}"
        exit 1
        ;;
esac
