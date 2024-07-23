import boto3
import os

region = os.environ['region']
tagname = os.environ['tagname']
tagvalue = os.environ['tagvalue']


def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'tag:'+tagname,
                'Values': [tagvalue]
            }
        ]
    )

    instancelist = []
    for reservation in (response["Reservations"]):
        for instance in reservation["Instances"]:
            if instance["State"]['Name'] == "running":
                instancelist.append(instance["InstanceId"])

    if instancelist != []:
        ec2.stop_instances(InstanceIds=instancelist)
        for i in instancelist:
            print('stopped your instances: ' + str(i))
