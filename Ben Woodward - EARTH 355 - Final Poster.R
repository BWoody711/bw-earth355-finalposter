library(ggplot2)
library(ggpubr)

#setwd("D:/OneDrive - University of Waterloo/Courses/Earth 355")

huron <- read.csv("./huron_icecover_precip_offset.csv", sep=";")

hist(huron$LakeLevel)

ggplot(huron, aes(x=IceCover, y=LakeLevel)) +
  geom_point() +
  geom_smooth(method='lm', se=FALSE) +
  stat_regline_equation(label.x = 30, label.y = 177.2) +
  stat_cor(aes(label=..rr.label..), label.x=30, label.y=177.1)
