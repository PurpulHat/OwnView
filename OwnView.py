import yaml
import requests
from pyvis.network import Network
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


def SendOutPut(group, action, data):
        if config[group][action][0]["output"][0]["shell_output"] == True:
            print(data)
            #net.from_nx(data)
            #net.show("test.html")

 

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

        # Execution if your child's groupe type is Python Code
        case "python":
            if value["module"] != None:
                a = f"import {value["module"]}"
                print(a)
                exec(a)
                exec('import whois ; whois.whois("empirys.com")')
            #a = exec(value["function"].replace("FUZZ", search))
            print("TEST")
            exec("print(\"Test\")")
            #print(a)
            


        # Execution if your child's groupe type is API
        case "api": 
            try:
                requests_headers = value["headers"].replace("FUZZ", search)
            except Exception:
                requests_headers = value["headers"]

            # Split URL and Params
            value["url"] = value["url"].replace("FUZZ", search)
            base_url, base_params = value["url"].split('?', 1) if '?' in value["url"] else (value["url"], '')

            if value["headers"] != None:
                data = requests.get(url=base_url, headers=value["headers"], params=base_params)

            else:
                response = ExecuteAttempt(requests.get(url=base_url, params=base_params))
                data = response.json()

            #SendOutPut("url", "ABC", data)
            #print(data)
            print(type)
            graph.BuildGraph(search, data, choice, type)
            