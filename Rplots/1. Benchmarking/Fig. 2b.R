
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/1. Benchmarking/') 

library(ggplot2)
library(paletteer)
library(reshape2)
library(readxl)

df = read_excel(paste0(workdir, "Fig. 2b_source_data.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df[which(df=="NA", arr.ind = T)] = 0
sta = apply(df, 2, function(x){length(which(as.numeric(x)>0))})
df = melt(as.data.frame(t(sta)))
colnames(df) = c("med","num")

ggplot(df, aes(x = med, y = num, fill = med)) +
  geom_bar(stat="identity", width = 0.5)+
  geom_text(aes(label = num), vjust = -0.3, size = 5, size.unit="pt")+
  theme_bw() +
  ylab("Number") +
  scale_fill_manual(values =  c(paletteer_d("ggthemes::Tableau_10"), "#CAB2D6FF")) +
  theme(text=element_text(size=7,  family="sans"),
        strip.text = element_text(size=7, family="sans"),
        legend.position = "none",
        axis.title.x=element_blank(), 
        axis.text.x = element_text(size=7, family="sans", angle = 45, hjust = 1),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Fig. 2b.pdf",width = 88, height = 70, units = "mm",
       dpi=300)


