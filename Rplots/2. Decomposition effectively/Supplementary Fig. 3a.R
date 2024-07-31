
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/2. Decomposition effectively/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)
library(scales)

df = read_excel(paste0(workdir, "Supplementary Fig. 3a_source_data.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df = melt(df)
colnames(df) = c("med", "overlap")

ggplot(df, aes(x = med, y = overlap, fill = med)) +
  geom_boxplot(outlier.shape = NA, width = 0.5) +
  theme_bw() +
  scale_x_discrete(limits=c("HVGs","HIGs", "scCAD"),
                   labels=c("HVGs","HIGs", "scCAD"),
                   name = "Feature selection methods") +
  scale_y_continuous(limits=c(0,0.04), labels = percent, name = "Overlap Rate") +
  scale_fill_manual(values = paletteer_d("ggthemes::Tableau_10")) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none", 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 3a.png",width = 8, height = 6, device='png', dpi=300)

