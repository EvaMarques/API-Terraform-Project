import json
import random

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps(random_gen())
    }
    
    
def random_gen():
    return random.randint(0, 100)
    
