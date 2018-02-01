#hostzone=`aws route53 list-hosted-zones-by-name | jq '.HostedZones | map(select(.Name | contains("'$domain'"))) | .[0].Id' | sed -e 's:"/hostedzone/\(.*\)":\1:g'`
#'.HostedZones | map(select(.Name | contains("'$domain'"))) | .[0].Id' | sed -e 's:"/hostedzone/\(.*\)":\1:g
#.HostedZones | map(select(.Name | contains("'test.com'"))) | .[0].Id
.HostedZones | map(select(.Name | contains($a))) | .[0].Id
