import requests
import os
import json
import boto3
import pandas as pd

def create_headers(bearer_token):
    headers = {"Authorization": "Bearer {}".format(bearer_token)}
    return headers

def get_stream(headers, bearer_token):
    # Query
    query = "?query=samuel garcia lang:es&max_results=11"
    # Fields
    fields = "&tweet.fields=created_at,source,author_id,public_metrics&expansions=author_id"
    # Params
    params = query +  fields
    response = requests.get(
        "https://api.twitter.com/2/tweets/search/recent" + params,
        headers=headers, stream=True,
    )
    print(f"Status response code: {response.status_code}")
    if response.status_code != 200:
        raise Exception(
            "Cannot get stream (HTTP {}): {}".format(
                response.status_code, response.text
            )
        )
    for response_line in response.iter_lines():
        if response_line:
            json_response = json.loads(response_line)
            print(json.dumps(json_response, indent=4, sort_keys=True))

def main():
    bearer_token = os.environ.get("BEARER_TOKEN")
    headers = create_headers(bearer_token)
    get_stream(headers, bearer_token)

if __name__ == "__main__":
    main()