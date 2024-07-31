
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/11. Retina & B_lymphoma datasets analysis/')  

library(paletteer)
library(ggplot2)

lab = read.table(paste0(workdir, "Fig. 9d_9e_source_data1_lab.txt"))[,1]
scCAD_res = read.table(paste0(workdir, "Fig. 9d_9e_source_data3_scCAD_res.txt"))[,1]
load(paste0(workdir, "Fig. 9d_9e_source_data2_tsne.Rdata"))

temp_tsne_out = cbind(tsne_out$Y, lab)
colnames(temp_tsne_out) = c("V1","V2","label")
temp_tsne_out = as.data.frame(temp_tsne_out)
temp_tsne_out$V1 = as.numeric(temp_tsne_out$V1)
temp_tsne_out$V2 = as.numeric(temp_tsne_out$V2)

ggplot(temp_tsne_out, aes(x=V1, y=V2, color=label)) + 
  geom_point(size = 0.2, stroke = 0) +
  theme_bw() +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.01,"cm"),
        legend.key.height=unit(0.01,"cm"),
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(-10,0,-10,-5),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1)))
ggsave(path = workdir, filename = "Fig. 9d.pdf",width = 65, height = 50, units = "mm",
       dpi=300)

##################

temp_tsne_out = cbind(tsne_out$Y, scCAD_res)
colnames(temp_tsne_out) = c("V1","V2","label")
temp_tsne_out = as.data.frame(temp_tsne_out)
temp_tsne_out$label = factor(scCAD_res, levels = c("Abundant","R1", "R2", "R3", "R4", "R5"))
temp_tsne_out$V1 = as.numeric(temp_tsne_out$V1)
temp_tsne_out$V2 = as.numeric(temp_tsne_out$V2)

ggplot(temp_tsne_out, aes(x=V1, y=V2, color=label)) + 
  geom_point(size = 0.2, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_dynamic("cartography::multi.pal", 20))) +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.01,"cm"),
        legend.key.height=unit(0.01,"cm"),
        legend.margin=margin(0,0,0,0),
        legend.box.margin=margin(-10,0,-10,-5),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1)))
ggsave(path = workdir, filename = "Fig. 9e_Rlab_tsne.pdf",width = 60, height = 50, units = "mm",
       dpi=300)



