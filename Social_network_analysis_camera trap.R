rm(list=ls())

# Load required libraries
library(igraph)
library(dplyr)
setwd("C:/Users/IT/Downloads")
# Load camera trap data
cam_trap_data <- read.csv("cam_data.csv")

# Identify individual animals
individuals <- unique(cam_trap_data$ï..animal_id)

# Create an empty adjacency matrix
adj_matrix <- matrix(0, nrow = length(individuals), ncol = length(individuals))

# Loop through each row of the camera trap data
for (i in 1:nrow(cam_trap_data)) {
  # Identify the source and target animals
  source <- which(individuals == cam_trap_data[i, "animal_id"])
  target <- which(individuals == cam_trap_data[i, "interaction_id"])
  
  # Add an edge to the adjacency matrix
  adj_matrix[source, target] <- adj_matrix[source, target] + 1
}

# Convert adjacency matrix to an igraph object
network <- graph.adjacency(adj_matrix, mode = "directed", weighted = TRUE)

# Calculate network metrics
centrality <- centr_degree(network, mode = "in")
closeness <- closeness(network, mode = "in")
betweenness <- betweenness(network, directed = TRUE)

# Plot the network
plot(network, vertex.size = centrality$theoretical_max*10, vertex.label = NA)
