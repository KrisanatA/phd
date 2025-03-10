library(tidyverse)

file <- tidytuesdayR::tt_load("2020-06-23")

locations <- file[[1]]

individuals <- file[[2]]

save(locations, individuals, file = "data/caribou/caribou.Rdata")


