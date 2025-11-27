#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
PageRank computation in linear time from a .txt adjacency list.

Input format (each line):
    node:neighbor1 neighbor2 neighbor3

Example:
    0:1 2 3
    1:2
    2:0 3
    3:

This script:
1. Reads a .txt file.
2. Builds adjacency lists and outdegrees.
3. Computes PageRank using sparse, linear-time power iteration.

Follows PEP 8 and PEP 257.
"""

from __future__ import annotations
from typing import Dict, List
import numpy as np


def read_graph(path: str) -> Dict[int, List[int]]:
    """
    Read a graph from a .txt file with the format:
        i:n1 n2 n3

    Parameters
    ----------
    path : str
        Path to the .txt file.

    Returns
    -------
    graph : dict[int, list[int]]
        Dictionary mapping each node to its list of outgoing neighbors.
    """
    graph: Dict[int, List[int]] = {}

    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue

            left, right = line.split(":")
            node = int(left)

            if right.strip() == "":
                graph[node] = []
            else:
                neighbors = [int(x) for x in right.split()]
                graph[node] = neighbors

    return graph


def pagerank_linear(
    graph: Dict[int, List[int]],
    alpha: float = 0.85,
    tol: float = 1e-8,
    max_iter: int = 100
) -> np.ndarray:
    """
    Compute PageRank using sparse linear-time PageRank iterations.

    Parameters
    ----------
    graph : dict[int, list[int]]
        Adjacency list for the graph.
    alpha : float
        Damping factor (0.85 by default).
    tol : float
        Convergence tolerance on the L1 norm.
    max_iter : int
        Maximum number of iterations.

    Returns
    -------
    rank : np.ndarray
        Array of PageRank values for nodes sorted by node id.
    """
    nodes = sorted(graph.keys())
    n = len(nodes)

    # Map node -> index
    index = {node: i for i, node in enumerate(nodes)}

    outdeg = np.zeros(n, dtype=np.int64)
    for u in nodes:
        outdeg[index[u]] = len(graph[u])

    # Transition structure
    # Build list of incoming links for efficiency (linear-time passes)
    incoming = [[] for _ in range(n)]
    for u in nodes:
        u_idx = index[u]
        for v in graph[u]:
            incoming[index[v]].append(u_idx)

    # Initialize rank vector
    rank = np.full(n, 1.0 / n)

    for _ in range(max_iter):
        new_rank = np.zeros(n)
        sink_mass = np.sum(rank[outdeg == 0])

        # Push contributions (linear in V + E)
        for i in range(n):
            contrib = rank[i] / outdeg[i] if outdeg[i] > 0 else 0.0
            for v in graph[nodes[i]]:
                new_rank[index[v]] += alpha * contrib

        # Add teleportation + leaked mass
        new_rank += (1 - alpha) / n
        new_rank += alpha * sink_mass / n

        # Convergence check
        if np.linalg.norm(new_rank - rank, 1) < tol:
            break

        rank = new_rank

    return rank


def main():
    """Example usage: read file, compute PageRank, and print sorted results."""
    import sys

    if len(sys.argv) != 2:
        print("Usage: python pagerank_linear.py graph.txt")
        raise SystemExit(1)

    path = sys.argv[1]
    graph = read_graph(path)
    rank = pagerank_linear(graph)
    nodes = sorted(graph.keys())

    print("=== PageRank Results ===")
    for node, r in zip(nodes, rank):
        print(f"Node {node}: {r:.6f}")


if __name__ == "__main__":
    main()

