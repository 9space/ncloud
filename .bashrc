source $NINE_CLOUD_ROOT/lib/init
source $NINE_CLOUD_ROOT/lib/docker-init
source $NINE_CLOUD_ROOT/commands/nine-cloud-shell

export CLICOLOR=1

echo
echo Welcome to Nine Cloud Client
echo
echo This is a special docker container to help you
echo   1. Set up your AWS EC2 Account using aws
echo   2. Manage your Kubenete AWS using kube-aws
echo   3. Manage your Kubenete Nodes using kube-config
echo

if [ "$NINE_CLOUD_ACCOUNT_ID" == "" ]; then
    ninecloud_login
elif [ "$NINE_CLOUD_ACCESS_TOKEN" == "" ]; then
    ninecloud_login
elif [ "$NINE_CLOUD_ACCOUNT_USER" == "" ]; then
    ninecloud_login
elif [ "$NINE_CLOUD_ACCOUNT_EMAIL" == "" ]; then
    ninecloud_login
fi
