.[] | map(select(.SourceSecurityGroup.GroupName | contains($a))) | .[] | { CanonicalHostedZoneNameID: .CanonicalHostedZoneNameID, Instances: .Instances, DNSName: .DNSName, LoadBalancerName: .LoadBalancerName, GroupName: .SourceSecurityGroup.GroupName }