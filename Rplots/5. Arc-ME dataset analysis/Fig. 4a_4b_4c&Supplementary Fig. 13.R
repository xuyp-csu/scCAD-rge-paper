
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/5. Arc-ME dataset analysis/')  

library(ggplot2)
library(paletteer)
library(reshape2)
library(RColorBrewer)

load(paste0(workdir, "Fig. 4a_source_data2_lab.Rdata"))
tsne_meta = read.csv(paste0(workdir, "Fig. 4a_source_data1_tsne.csv"))
rownames(tsne_meta) = tsne_meta[,1]
tsne_meta = tsne_meta[,-1]
tsne_out = cbind(tsne_meta, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

n <- length(unique(lab))
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
set.seed(2023)
pal = sample(col_vector, length(unique(lab)))

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.3, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = pal) +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.11,"cm"),
        legend.key.height=unit(0.02,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1)))
ggsave(path = workdir, filename = "Fig. 4a.pdf",width = 110, height = 70, units = "mm",
       dpi=300)

##################### rare cell type ###########################

load(paste0(workdir, "Fig. 4b_source_data_rare_cell_lab.Rdata"))
temp_tsne_out = tsne_out
temp_tsne_out$label = rare_cell_lab
ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.3, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", "#377EB8", "#6A3D9A", "#F1E2CC", "#BEBADA",
                                "#984EA3", "#386CB0", "#8DD3C7", "#FDC086", "#CCCCCC", "#FFFF99",
                                "#DECBE4", "#FF7F00", "#1B9E77", "#66C2A5", "#FFFFCC", "#4DAF4A",
                                "#B3CDE3", "#FDB462", "#FED9A6", "#F0027F")) +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.05,"cm"),
        legend.key.height=unit(0.01,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1.5)))
ggsave(path = workdir, filename = "Fig. 4b_Rlab.pdf",width = 60, height = 40, units = "mm",
       dpi=300)

##################### scCAD ###########################

scCAD_res = read.table(paste0(workdir, "Fig. 4c_source_data_scCAD_res.txt"))[,1]
temp_tsne_out = tsne_out
temp_tsne_out$label = scCAD_res

ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.3, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10"))) +
  theme(text=element_blank(),
        legend.text = element_text(size=5,  family="sans"),
        legend.title = element_blank(),
        axis.ticks.x=element_blank(), 
        axis.ticks.y=element_blank(), 
        legend.position = "right",
        legend.key.width=unit(0.05,"cm"),
        legend.key.height=unit(0.01,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 1.5)))
ggsave(path = workdir, filename = "Fig. 4c_scCAD_res.pdf",width = 60, height = 40, units = "mm",
       dpi=300)


##################### EDGE ###########################

EDGE_res = read.table(paste0(workdir, "Supplementary Fig. 13_source_data1_EDGE_res.txt"))[,1]
temp_tsne_out = tsne_out
temp_tsne_out$label = EDGE_res

ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c("#BAB0ACFF", "#E15759FF")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = c(.99, .99),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 13_EDGE_res.png",width = 8, height = 6, device='png', dpi=300)

##################### FiRE ###########################

FiRE_res = read.table(paste0(workdir, "Supplementary Fig. 13_source_data2_FiRE_res.txt"))[,1]
temp_tsne_out = tsne_out
temp_tsne_out$label = FiRE_res

ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c("#BAB0ACFF", "#E15759FF")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = c(.99, .99),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 13_FiRE_res.png",width = 8, height = 6, device='png', dpi=300)

##################### GapClust ###########################

GapClust_res = read.table(paste0(workdir, "Supplementary Fig. 13_source_data3_GapClust_res.txt"))[,1]
temp_tsne_out = tsne_out
temp_tsne_out$label = GapClust_res

ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c("#BAB0ACFF", "#E15759FF")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = c(.99, .99),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 13_GapClust_res.png",width = 8, height = 6, device='png', dpi=300)

##################### SCA ###########################

SCA_res = read.table(paste0(workdir, "Supplementary Fig. 13_source_data4_SCA_res.txt"))[,1]
temp_tsne_out = tsne_out
temp_tsne_out$label = SCA_res

ggplot(temp_tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c("#BAB0ACFF", "#E15759FF")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = c(.99, .99),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 13_SCA_res.png",width = 8, height = 6, device='png', dpi=300)


