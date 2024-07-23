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
            if instance["State"]['Name'] == "stopped":
                instancelist.append(instance["InstanceId"])

    if instancelist != []:
        ec2.start_instances(InstanceIds=instancelist)
        for instance in instancelist:
            print('instance name: ' + str(instance))

# https://aws.amazon.com/premiumsupport/knowledge-center/start-stop-lambda-cloudwatch/
# https://www.slsmk.com/using-python-and-boto3-to-get-instance-tag-information/