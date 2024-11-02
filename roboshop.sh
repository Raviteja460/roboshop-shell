#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-090089ab959fa4c19 #replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")
ZONE_ID=Z0119625R3T3BXCBZ22N
DOMAIN_NAME="devops474.online"

for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
done
    # IP_ADDRESS=$(aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCE_TYPE --security-group-ids sg-090089ab959fa4c19 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
    # echo "$i: $IP_ADDRESS"

    # #create R53 record, make sure you delete existing record
    # aws route53 change-resource-record-sets \
    # --hosted-zone-id $ZONE_ID \
    # --change-batch '
    # {
    #     "Comment": "Creating a record set for cognito endpoint"
    #     ,"Changes": [{
    #     "Action"              : "UPSERT"
    #     ,"ResourceRecordSet"  : {
    #         "Name"              : "'$i'.'$DOMAIN_NAME'"
    #         ,"Type"             : "A"
    #         ,"TTL"              : 1
    #         ,"ResourceRecords"  : [{
    #             "Value"         : "'$IP_ADDRESS'"
    #         }]
    #     }
    #     }]
    # }