
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/1. Benchmarking/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)

df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data1.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df = melt(df, measure.vars = colnames(df))
colnames(df) = c("med","G")
df$med = factor(df$med, levels = c("scCAD", setdiff(sort(unique(as.character(df$med))),"scCAD")))
df[which(df=="NA", arr.ind = T)]=0
df$G = as.numeric(df$G)

ggplot(df, aes(x = med, y = G, fill = med)) +
  geom_boxplot(width = 0.5, outlier.shape = NA)+
  theme_bw() +
  ylab("G-Mean") +
  scale_fill_manual(values = c(paletteer_d("ggthemes::Tableau_10"), "#CAB2D6FF")) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none",
        axis.title.x=element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 1a.png",width = 14, height = 6, device='png', dpi=300)

df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data2.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df = melt(df, measure.vars = colnames(df))
colnames(df) = c("med","MCC")
df$med = factor(df$med, levels = c("scCAD", setdiff(sort(unique(as.character(df$med))),"scCAD")))
df[which(df=="NA", arr.ind = T)]=0
df$MCC = as.numeric(df$MCC)

ggplot(df, aes(x = med, y = MCC, fill = med)) +
  geom_boxplot(width = 0.5, outlier.shape = NA)+
  theme_bw() +
  ylab("MCC") +
  scale_fill_manual(values = c(paletteer_d("ggthemes::Tableau_10"), "#CAB2D6FF")) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none",
        axis.title.x=element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 1b.png",width = 14, height = 6, device='png', dpi=300)

df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data3.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df = melt(df, measure.vars = colnames(df))
colnames(df) = c("med","Kappa")
df$med = factor(df$med, levels = c("scCAD", setdiff(sort(unique(as.character(df$med))),"scCAD")))
df[which(df=="NA", arr.ind = T)]=0
df$Kappa = as.numeric(df$Kappa)

ggplot(df, aes(x = med, y = Kappa, fill = med)) +
  geom_boxplot(width = 0.5, outlier.shape = NA)+
  theme_bw() +
  ylab("Kappa") +
  scale_fill_manual(values = c(paletteer_d("ggthemes::Tableau_10"), "#CAB2D6FF")) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none",
        axis.title.x=element_blank(), 
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 1c.png",width = 14, height = 6, device='png', dpi=300)





