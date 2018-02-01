#!/bin/sh

NINE_CLOUD_ROOT=/home/ncloud
#NINE_CLOUD_CONFIG=/data/.ncloud/foobar

# LOGIN and obtain credentials etc

export NINE_CLOUD_DEBUG=""
#echo $NINE_CLOUD_ROOT/ncloud shell -s "$@"
#exec $NINE_CLOUD_ROOT/ncloud shell -s "$@"
#echo $@
exec $NINE_CLOUD_ROOT/ncloud shell -s "$@"
#exec $NINE_CLOUD_ROOT/ncloud shell "run kc get pods"
