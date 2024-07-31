
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/9. ccRCC datasets analysis/')  

library(ggplot2)
library(paletteer)
library(reshape2)

load(paste0(workdir, "Fig. 8d_8e_8f_source_data1_Kidney_ccRCC_umap.Rdata"))
lab = read.table(paste0(workdir, "Fig. 8d_8e_8f_source_data2_Kidney_ccRCC_lab.txt"))[,1]

umap = cbind(umap, lab)
colnames(umap) = c("umap_1", "umap_2", "label")
ggplot(umap, aes(x=umap_1, y=umap_2, color=label)) + 
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
ggsave(path = workdir, filename = "Fig. 8d.pdf",width = 60, height = 50, units = "mm",
       dpi=300)

n_cells = length(lab)
rare_h = floor(0.01*n_cells)
t_list = c()
for (t in as.character(unique(umap$label))) {
  id = which(umap$label == t)
  if(length(id)<=rare_h){
    t_list = c(t_list, t)
  }
}

rare_cell_type = rep("Abundant", n_cells)
names(rare_cell_type) = rownames(umap)
rare_cell_id = c()
for (l in t_list) {
  rare_cell_id = c(rare_cell_id, which(umap$label==l))
  rare_cell_type[which(umap$label==l)] = l
}

temp_umap = umap
temp_umap$label = rare_cell_type
ggplot(temp_umap, aes(x=umap_1, y=umap_2, color=label)) + 
  geom_point(size = 0.2, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10"))) +
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
ggsave(path = workdir, filename = "Fig. 8e_Rlab.pdf",width = 60, height = 50, units = "mm",
       dpi=300)

scCAD_res = read.table(paste0(workdir, "Fig. 8d_8e_8f_source_data3_Kidney_ccRCC_scCAD_res.txt"))[,1]
temp_umap = umap
temp_umap$label = scCAD_res
temp_umap$label = factor(temp_umap$label, levels = c("Abundant","R1","R2","R3","R4","R5","R6", "R7"))

ggplot(temp_umap, aes(x=umap_1, y=umap_2, color=label)) + 
  geom_point(size = 0.2, stroke = 0) +
  theme_bw() +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10")[-10], "#D5E4A2", "#D2AF81", "#78909C")) +
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
ggsave(path = workdir, filename = "Fig. 8f_scCAD.pdf",width = 56, height = 50, units = "mm",
       dpi=300)



