import requests
import os
import json
import pandas as pd

def create_headers(bearer_token):
    headers = {"Authorization": "Bearer {}".format(bearer_token)}
    return headers

def get_rules(headers, bearer_token):
    response = requests.get(
        "https://api.twitter.com/2/tweets/search/stream/rules", headers=headers
    )
    if response.status_code != 200:
        raise Exception(
            "Cannot get rules (HTTP {}): {}".format(response.status_code, response.text)
        )
    print(json.dumps(response.json()))
    return response.json()


def delete_all_rules(headers, bearer_token, rules):
    if rules is None or "data" not in rules:
        return None

    ids = list(map(lambda rule: rule["id"], rules["data"]))
    payload = {"delete": {"ids": ids}}
    response = requests.post(
        "https://api.twitter.com/2/tweets/search/stream/rules",
        headers=headers,
        json=payload
    )
    if response.status_code != 200:
        raise Exception(
            "Cannot delete rules (HTTP {}): {}".format(
                response.status_code, response.text
            )
        )
    print(json.dumps(response.json()))

"""
General => #Elecciones2021MX, #Elecciones2021, #ContamosTodos, #ContamosTodas

INE => #VotarEsSeguro, #Certeza2021

Morena => #VotaTODOMorena, #VotoMasivoPorMorena2021, #DefendamosLaEsperanza

PRI => #VotaPRI, #MorenaDestruyeMéxico

AccionNacional => #VotaPAN, #CambiemosElRumbo

Movimiento Ciudadano => #MovimientoCiudano, #movimientonaranja, #HaganSuParte

PRD => #VotaPRD, #VotoÚtil
"""

def set_rules(headers, delete, bearer_token):
    sample_rules = [
        #{"value": "(#Elecciones2021MX OR #ContamosTodos OR #ContamosTodas) lang:es", "tag": "Elecciones 2021"},
        #{"value": "(#VotarEsSeguro OR #VotoInformado OR #Certeza2021 OR @INEMexico) lang:es", "tag": "INE"},
        #{"value": "(#VotaTODOMorena OR #VotoMasivoPorMorena2021 OR @PartidoMorenaMx) lang:es", "tag": "morena"},
        #{"value": "(#MovimientoCiudano OR #movimientonaranja OR #HaganSuParte OR @MovCiudadanoMX) lang:es", "tag":"Movimiento Ciudadano"},
        #{"value": "(#VotaPRI OR #MorenaDestruyeMéxico OR @PRI_Nacional) lang:es", "tag": "PRI"},
        #{"value": "(#VotaPAN OR #CambiemosElRumbo OR @AccionNacional) lang:es", "tag": "PAN"},
        #{"value": "#VaPorMexico lang:es", "tag": "VaPorMexico"},
        #{"value": "(#VotaPRD OR#VotoÚtil OR @PRDMexico) lang:es", "tag": "PRD"},
        #{"value":"(@PESNacionalMX OR #VotaPES) lang:es", "tag":"PES"},
        {"value":'("Clara Luz" OR @claraluzflores OR to:claraluzflores OR #ClaraGobernadora OR #VotaClara OR #EquipoPorNuevoLeón) lang:es', "tag":"Clara Luz"},
        {"value":'("Samuel Garcia" OR @samuel_garcias OR to:samuel_garcias OR #LaViejaPolítica OR @colosioriojas) lang:es', "tag":"Samuel Garcia"},
        {"value":'("Adrian de la Garza" OR @AdrianDeLaGarza OR to:AdrianDeLaGarza OR #TodoVaAEstarBien) lang:es', "tag":"Adrian de la Garza"},
        {"value": '("Fernando Larrazabal" OR @FerLarrazabalNL OR to:FerLarrazabalNL OR #LarrazabalGobernador) lang:es', "tag":"Fernando Larrazabal"}
    ]
    payload = {"add": sample_rules}
    response = requests.post(
        "https://api.twitter.com/2/tweets/search/stream/rules",
        headers=headers,
        json=payload,
    )
    if response.status_code != 201:
        raise Exception(
            "Cannot add rules (HTTP {}): {}".format(response.status_code, response.text)
        )
    print(json.dumps(response.json()))


def get_stream(headers, set, bearer_token):
    params = "?tweet.fields=created_at,attachments,context_annotations,entities,geo,in_reply_to_user_id,public_metrics,referenced_tweets,source&expansions=author_id&user.fields=public_metrics,created_at,description,location,protected,verified"
    with requests.get("https://api.twitter.com/2/tweets/search/stream" + params, headers=headers, stream=True) as response:
        print(response.status_code)
        if response.status_code != 200:
            raise Exception(
                "Cannot get stream (HTTP {}): {}".format(
                    response.status_code, response.text
                )
            )
        tweet_id = int(os.popen('ls data-6-junio-ii | wc -l').readlines()[0].replace("\n", ""))
        for response_line in response.iter_lines():
            if response_line:
                tweet_id += 1
                json_response = json.loads(response_line)
                print(json.dumps(json_response, indent=4, sort_keys=True))
                with open('data-6-junio-ii/%d.json' % tweet_id, 'w+') as outfile:
                    json.dump(json_response, outfile)

def main():
    bearer_token = os.environ.get("BEARER_TOKEN")
    headers = create_headers(bearer_token)
    rules = get_rules(headers, bearer_token)
    delete = delete_all_rules(headers, bearer_token, rules)
    set = set_rules(headers, delete, bearer_token)
    get_stream(headers, set, bearer_token)

if __name__ == "__main__":
    main()
