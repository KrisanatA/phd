library(tibble)
library(stats)
library(dplyr)

set.seed(1)

n_node <- 20
australia_bounding <- c(145.081, -37.889, 145.200, -37.200)
type <- c("age_care", "hospital")
size <- round(runif(n_node, min = 20, max = 500))

nodes <- tibble(id = seq(1, n_node, 1), 
                lat = runif(n_node, min = australia_bounding[2], max = australia_bounding[4]), 
                lon = runif(n_node, min = australia_bounding[1], max = australia_bounding[3]), 
                type = sample(type, size = n_node, replace = TRUE), 
                size = sample(size))

n_edge <- 100
timestamp <- seq(as.POSIXct("2025-01-01 00:00:00"),
                as.POSIXct("2025-02-15 00:00:00"),
                by = "hour")
reason <- c("chest_pain", "breathing_issue", "injury", "stroke", "seizures", "high_fever")

edges <- tibble(from = sample(seq(1, n_node, 1), size = n_edge, replace = TRUE),
                to = sample(seq(1, n_node, 1), size = n_edge, replace = TRUE),
                timestamp = sample(timestamp, size = n_edge, replace = TRUE),
                reason = sample(reason, size = n_edge, replace = TRUE)) |>
        filter(from != to)

save(nodes, edges, file = "data/toy/sim_network.RData")