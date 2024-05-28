
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/2. Decomposition effectively/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)
library(scales)

load(paste0(workdir, "Supplementary Fig. 3_source_data.Rdata"))

df = as.data.frame(ARI_res)
df = cbind(df, rownames(df))
rownames(df) = NULL
colnames(df) = c("ARI", "Dataset")

ggplot(df, aes(x = Dataset, y = ARI)) +
  geom_col(colour="black",width=0.5,    
           position=position_dodge(0.5)) +
  theme_bw() +
  xlab("") +
  ylab("ARI") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.position = "none",
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 3.png",width = 10, height = 8, device='png', dpi=300)

