'''Lambda handler to generate a random number'''

import json
import random


def lambda_handler(_event, _context):
    '''Returns an object that the lambda will use'''

    return {
        'statusCode': 200,
        'body': json.dumps(random_gen())
    }


def random_gen():
    '''Returns a random number between 0 and 100'''

    return random.randint(0, 100)
