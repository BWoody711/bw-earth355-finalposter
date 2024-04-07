library(ggplot2)
library(ggpubr)
library(rstudioapi)

setwd(dirname(getActiveDocumentContext()$path))

huron <- read.csv("./huron_icecover_precip_offset.csv", sep=";")

lm_model <- lm(LakeLevel ~ Precip, data = huron)

residuals <- resid(lm_model)

ggplot(data = data.frame(Residuals = residuals), aes(sample = Residuals)) +
  stat_qq() +
  geom_abline(intercept = mean(residuals), slope = sd(residuals)) +
  ggtitle("QQ Plot")

title="Scatterplot of Values with Regression Line"

ggplot(huron, aes(x=Precip, y=LakeLevel)) +
  geom_point() +
  geom_abline(slope = coef(lm_model)[2], intercept = coef(lm_model)[1]) +
  geom_text(aes(label = paste("Y =", round(coef(lm_model)[1], 5), "+", round(coef(lm_model)[2], 5), "* X")), x = -Inf, y = Inf, hjust = -0.05, vjust = 1.5) + 
  geom_text(aes(label = paste("R-squared =", round(summary(lm_model)$r.squared, 5))), x = -Inf, y = Inf, hjust = -0.05, vjust = 3) + 
  ggtitle(title) + 
  xlab("Basin-Wide Precipitation (mm)") +
  ylab("Lake Level (MASL)")

ggsave(paste("../",title,".png",sep=""))