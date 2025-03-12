# library
library(tidyverse)
library(sfnetworks)
library(sf)
library(ggplot2)
library(ggraph)

# caribou data
load(here::here("data/caribou/caribou.RData"))

locations
individuals

# try one caribou first

keep <- individuals |>
    filter(!is.na(death_cause)) |>
    pull(animal_id)

# try KE_car027

test <- locations |>
    filter(animal_id %in% keep) |>
    mutate(event_id = as.character(event_id)) |>
    arrange(animal_id, timestamp)

# try from to to structure

nodes <- test |>
    select(event_id, latitude, longitude, season) |>
    rename(id = event_id)

nodes

edges <- test |>
    select(event_id, timestamp) |>
    mutate(to = lead(event_id)) |>
    rename(from = event_id) |>
    filter(!is.na(to)) |>
    select(from, to, timestamp)

edges

nodes_sf <- st_as_sf(nodes, coords = c("latitude", "longitude"))

sfnetwork_obj <- sfnetwork(nodes_sf, edges)

# double will not work when joining the network data for this specific example because the double is to large


layout_sf <- function(graph) {
    graph = activate(graph, "nodes")
    x = sf::st_coordinates(graph)[, "X"]
    y = sf::st_coordinates(graph)[, "Y"]
    data.frame(x, y)
}


ggraph(sfnetwork_obj, layout = layout_sf) +
    geom_node_point() +
    geom_edge_link()


