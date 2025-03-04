import networkx as nx
import webbrowser
from pyvis.network import Network

graph_created = False

if graph_created is False:
    G = nx.Graph()
    graph_created == True

def BuildGraph(input, data, choice, type):
    G.add_node(input)

    def print_str_values(d):
        for key, value in d.items():
            if isinstance(value, str):
                G.add_node(value)
                G.add_edge(value, key)
                G.add_edge(key, input)

            elif isinstance(value, dict):
                print_str_values(value)  # Appel récursif pour les dictionnaires imbriqués
                
            elif isinstance(value, list):
                for item in value:
                    if isinstance(item, dict):
                        print_str_values(item)  # Appel récursif pour les dictionnaires dans les listes

    # Appel de la fonction avec le dictionnaire data
    print_str_values(data)

    node_degree = dict(G.degree)
    nx.set_node_attributes(G, node_degree, 'size')

    # Create a Pyvis network from the NetworkX graph
    net = Network(notebook=True, height=1000, bgcolor='#222222', font_color='white')
    net.from_nx(G)

    net.show(f"./OwnView_{input}_{choice}_{type}.html")
    webbrowser.open(f"./OwnView_{input}_{choice}_{type}.html")
