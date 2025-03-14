import yaml
import requests
import graph

print("""
 ██████╗ ██╗    ██╗███╗   ██╗    ██╗   ██╗██╗███████╗██╗    ██╗    
██╔═══██╗██║    ██║████╗  ██║    ██║   ██║██║██╔════╝██║    ██║    
██║   ██║██║ █╗ ██║██╔██╗ ██║    ██║   ██║██║█████╗  ██║ █╗ ██║    
██║   ██║██║███╗██║██║╚██╗██║    ╚██╗ ██╔╝██║██╔══╝  ██║███╗██║    
╚██████╔╝╚███╔███╔╝██║ ╚████║     ╚████╔╝ ██║███████╗╚███╔███╔╝    
 ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝      ╚═══╝  ╚═╝╚══════╝ ╚══╝╚══╝     
                                                     @PurpulHat""")

with open("config.yml", "r") as file:
    config = yaml.safe_load(file)



# Try to execute the fuction 3 time before return an error
def ExecuteAttempt(execute):
     for attempt in range(3):
        try:
            execute
            if execute == None:
                continue

        except Exception as error:
            if attempt > 3:
                print(f"[ERROR] : {error}")

        return execute


 
def Fuzz(config_child):
    try:
        return value[config_child].replace("FUZZ", search)
    except Exception:
        return value[config_child]



print("[Enumeration of groups in your config.yml]")
number_of_group = 0
for group, value in config.items():
    print(f"[{number_of_group}] : {group}")
    number_of_group += 1

# Ask what group (from config.yml) you want to use
while True:
    try:
        choice = int(input("\n[?] What group to use : "))
        choice = list(config)[choice]
        break
    except Exception:
        print("[!] : Choose a number")
search = input("[?] Your input        : ")
print("")


for type, value in config[choice].items():
    value = value[0]

    match value["type"]:
        case "api":

            # Get "FUZZ" value and replace it from your search input
            for fuzz_check in ["body","headers","url"]:
                try:
                    for fuzz in value[fuzz_check][0]:
                        try:
                            value[fuzz_check][0][fuzz] = value[fuzz_check][0][fuzz].replace("FUZZ", search)
                        except:
                            continue
                except TypeError:
                    value[fuzz_check] = value[fuzz_check].replace("FUZZ", search)
            
            # Split URL and Params
            base_url, base_params = value["url"].split('?', 1) if '?' in value["url"] else (value["url"], '')

            match value["method"].upper():
                case "GET":
                    response = requests.get(url=base_url, headers=value["headers"], params=base_params)
                    data = response.json()
                case "POST":
                    response = requests.post(url=base_url, headers=value["headers"][0], params=base_params, json=value["body"][0])
                    data = response.json()
                case _:
                    print("[!] HTTP Method not supported (GET or POST only) :: Skip")
            
            if value["output"][0]["shell"] == True:
                print(data)
            if value["output"][0]["graph"] == True:
                graph.BuildGraph(search, data, choice, type)

