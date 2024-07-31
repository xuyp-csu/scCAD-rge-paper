
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/6. intestine dataset analysis/')  

library(ggplot2)
library(paletteer)
library(reshape2)
library(RColorBrewer)

load(paste0(workdir, "Fig. 5a_source_data1_tsne.Rdata"))
scCAD_res = read.table(paste0(workdir, "Fig. 5a_source_data2_scCAD_res.txt"))[,1]
tsne_out = cbind(tsne_out, scCAD_res)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.5, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10"))) +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.1,"cm"),
        legend.key.height=unit(0.1,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1)))
ggsave(path = workdir, filename = "Fig. 5a.pdf",width = 80, height = 65, units = "mm",
       dpi=300)
