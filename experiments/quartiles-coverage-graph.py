#!/usr/bin/env python3

### COVERAGE GRAPH

import matplotlib.pyplot as plt
import csv
import sys
import numpy as np

    
def generate_graph(x_padding, y_padding, step, input_file, output_file):
    rows = []
    max_value = 0
    index = 0
    scatters = []
    algorithms = []
        
    with open(input_file, 'r') as csvfile:
        plots = csv.reader(csvfile, delimiter=';')
        
        for row in plots:
            algorithms.append(row[0])
            filtered_row = list(map(lambda x: float(x), list(filter(lambda x: x != "", row[1:]))))
            rows.append(filtered_row)
            row_max = float(max(filtered_row))
            max_value = row_max if row_max > max_value else max_value
    
    fig, lines = plt.subplots()

    for row in rows:
        x = []
        y = []
        
        for j in range(1, len(row) - 1, step):
            y.append(float(row[j]) / max_value)
            x.append(float(j))
        
        scatters.append(plt.scatter(x, y, marker=['>', 'x', '+', '.', 'o', 'v', '2', 's', '<', 'p', 'P', 'X', 'd'][index], 
                                    color='black'))
        
        x = []
        y = []
        
        for j in range(0, len(row) - 1):
            y.append(float(row[j]) / max_value)
            x.append(float(j))
        
        plt.plot(x, y, marker="", color='black', linewidth=0.5)
        
        index += 1

    plt.xlabel('Number of Factors')
    plt.ylabel('Coverage')
    
    plt.ylim(0, 1.1)
    plt.xlim(xmin=-0.5)
    
    plt.tight_layout()
    lgd = plt.legend(scatters, 
               algorithms, 
               loc="lower right")
    plt.savefig(output_file, format='eps')
    
directory = 'results/quartiles-coverage/{}'
graphs_direcotry = 'results/graphs/quartiles-coverage/{}'
generate_graph(5,5000,10,directory.format('mushroom.csv'), graphs_direcotry.format('mushrooms.eps'))
generate_graph(30,2000,35,directory.format('advertisement.csv'), graphs_direcotry.format('advertisement.eps'))
generate_graph(10,5000,10,directory.format('americas_small.csv'), graphs_direcotry.format('americas_small.eps'))
generate_graph(20,500,20,directory.format('apj.csv'), graphs_direcotry.format('apj.eps'))
generate_graph(20,2000,10,directory.format('customer.csv'), graphs_direcotry.format('customer.eps'))
generate_graph(20,1000,30,directory.format('dna.csv'), graphs_direcotry.format('dna.eps'))
generate_graph(2,1500,8,directory.format('firewall1.csv'), graphs_direcotry.format('firewall1.eps'))
generate_graph(1,800,3,directory.format('tic_tac_toe.csv'), graphs_direcotry.format('tic_tac_toe.eps'))