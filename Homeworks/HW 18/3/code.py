import boto3
import json
import os

def lambda_handler(event, context):
    tag_name = os.environ.get("EC2_TAG", "ec-test")
    region = os.environ.get("AWS_REGION", "us-east-1")
    
    ec2 = boto3.client("ec2", region_name=region)
    
    response = ec2.describe_instances(
        Filters=[
            {"Name": "tag-key", "Values": [tag_name]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    
    instance_ids = [
        inst["InstanceId"]
        for r in response["Reservations"]
        for inst in r["Instances"]
    ]
    
    if not instance_ids:
        return {"statusCode": 200, "body": "There is no instances of ec2 " + tag_name}
    
    ec2.stop_instances(InstanceIds=instance_ids)
    
    return {"statusCode": 200, "body": json.dumps({"stopped": instance_ids})}