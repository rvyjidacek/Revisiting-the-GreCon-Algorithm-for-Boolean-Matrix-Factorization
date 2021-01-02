#!/usr/bin/env python3

import csv
import matplotlib.pyplot as plt

def factor_quartiles_graph(input_file, output_file):

    with open(input_file, 'r') as csvfile:  
        plots = csv.reader(csvfile, delimiter=';')
        rows = []
        x=[]
        y=[]

        for row in plots:
            rows.append(row)

        for j in range(1, len(row)):
            y.append(int(rows[1][j]))
            x.append(int(rows[0][j]))

        plt.scatter(x,y, marker='.', color="black")
        plt.tight_layout()
        plt.yticks([1, 2, 3, 4], ['Q1', 'Q2', 'Q3', 'Q4'])
        plt.savefig(output_file, format='eps')
        # plt.show()
        # plt.close()

factor_quartiles_graph('results/quartiles/apj.csv', 'results/graphs/quartiles/apj.eps')
factor_quartiles_graph('results/quartiles/americas_small.csv', 'results/graphs/quartiles/americas_small.eps')
factor_quartiles_graph('results/quartiles/advertisement.csv', 'results/graphs/quartiles/advertisement.eps')
factor_quartiles_graph('results/quartiles/customer.csv', 'results/graphs/quartiles/customer.eps')
factor_quartiles_graph('results/quartiles/dna.csv', 'results/graphs/quartiles/dna.eps')
factor_quartiles_graph('results/quartiles/firewall1.csv', 'results/graphs/quartiles/firewall1.eps')
factor_quartiles_graph('results/quartiles/tic_tac_toe.csv', 'results/graphs/quartiles/tic_tac_toe.eps')
factor_quartiles_graph('results/quartiles/mushroom.csv', 'results/graphs/quartiles/mushroom.eps')
