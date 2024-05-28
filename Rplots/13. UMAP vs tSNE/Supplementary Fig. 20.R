
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/13. UMAP vs tSNE/')  

library(ggplot2)
library(paletteer)
library(reshape2)
library(RColorBrewer)

##################### a. Airway ###########################

meta_data  <- read.table(paste0(workdir, "Supplementary Fig. 20a_source_data1_tsne.txt"), sep = "\t", header = T)
meta_data$mouse[which(meta_data$mouse=="WT_2")] = "WT_M2"
meta_data$mouse[which(meta_data$mouse=="Foxj1_GFP_M1")] = "Foxj1GFP_M1"
meta_data$mouse[which(meta_data$mouse=="Foxj1_GFP_M2")] = "Foxj1GFP_M2"
rownames(meta_data) = paste0(meta_data$mouse,"_",meta_data$barcode)
lab = meta_data$cluster

### tSNE ###

tsne_out = meta_data[,1:2]
tsne_out = as.data.frame(tsne_out)
tsne_out = cbind(tsne_out, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = paletteer_d("ggthemes::Tableau_10")) +
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
ggsave(path = workdir, filename = "Supplementary Fig. 20a_tsne.png",width = 8, height = 6, device='png', dpi=300)

### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20a_source_data2_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label)) + 
  geom_point(size = 0.8) +
  theme_bw() +
  xlab("Umap-1") +
  ylab("Umap-2") +
  scale_color_manual(values = paletteer_d("ggthemes::Tableau_10")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = c(.01, .99),
        legend.justification = c("left", "top"),
        legend.box.just = "left",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20a_umap.png",width = 8, height = 6, device='png', dpi=300)

##################### b. Arc-ME ###########################

### tSNE ###

load(paste0(workdir, "Supplementary Fig. 20b_source_data2_lab.Rdata"))
tsne_meta = read.csv(paste0(workdir, "Supplementary Fig. 20b_source_data1_tsne.csv"))
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
  geom_point(size = 0.5) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = pal) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=10, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.2,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20b_tsne.png",width = 12, height = 8, device='png', dpi=300)

### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20b_source_data3_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label)) +
  geom_point(size = 0.5) +
    theme_bw() +
    xlab("Umap-1") +
    ylab("Umap-2") +
    scale_color_manual(values = pal) +
    theme(text=element_text(size=15,  family="serif",face = 'bold'),
          strip.text = element_text(size=15, family="serif",face = 'bold'),
          legend.text = element_text(size=10, family="serif",face = 'bold'),
          legend.title = element_blank(),
          legend.position = "right",
          legend.key.width=unit(1,"cm"),
          legend.key.height=unit(0.2,"cm"),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
    guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20b_umap.png",width = 12, height = 8, device='png', dpi=300)

##################### c. Intestine ###########################

### tSNE ###
load(paste0(workdir, "Supplementary Fig. 20c_source_data1_tsne.Rdata"))
scCAD_res = read.table(paste0(workdir, "Supplementary Fig. 20c_source_data2_scCAD_res.txt"))[,1]
tsne_out = cbind(tsne_out, scCAD_res)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 1) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10"))) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20c_tsne.png",width = 8, height = 6, device='png', dpi=300)

### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20c_source_data3_umap.Rdata"))

umap = cbind(umap, scCAD_res)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label))+
  geom_point(size = 1) +
    theme_bw() +
    xlab("Umap-1") +
    ylab("Umap-2") +
    scale_color_manual(values = c("#BAB0ACFF", paletteer_d("ggthemes::Tableau_10"))) +
    theme(text=element_text(size=15,  family="serif",face = 'bold'),
          strip.text = element_text(size=15, family="serif",face = 'bold'),
          legend.text = element_text(size=15, family="serif",face = 'bold'),
          legend.title = element_blank(),
          legend.position = "right",
          legend.key.width=unit(1,"cm"),
          legend.key.height=unit(0.5,"cm"),
          panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
    guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20c_umap.png",width = 8, height = 6, device='png', dpi=300)

##################### d. Pancrea ###########################

### tSNE ###

load(paste0(workdir, "Supplementary Fig. 20d_source_data1_tsne.Rdata"))
lab = read.table(paste0(workdir, "Supplementary Fig. 20d_source_data2_lab.txt"))[,1]
n <- length(unique(lab))
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
set.seed(2023)
pal = sample(col_vector, length(unique(lab)))

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 1) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = pal) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.text = element_text(size=20, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20d_tsne.png",width = 12, height = 8, device='png', dpi=300)

### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20d_source_data3_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label)) +
  geom_point(size = 1) +
  theme_bw() +
  xlab("Umap-1") +
  ylab("Umap-2") +
  scale_color_manual(values = pal) +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.text = element_text(size=20, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20d_umap.png",width = 12, height = 8, device='png', dpi=300)

##################### e. Tcells ###########################

### tSNE ###
load(paste0(workdir,"Supplementary Fig. 20e_source_data1_tsne.Rdata"))
lab = read.table(paste0(workdir, "Supplementary Fig. 20e_source_data2_lab.txt"))[,1]

tsne_out = cbind(tsne_out, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.3) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20e_tsne.png",width = 12, height = 8, device='png', dpi=300)

### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20e_source_data3_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label))+
  geom_point(size = 0.3) +
  theme_bw() +
  xlab("Umap-1") +
  ylab("Umap-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20e_umap.png",width = 12, height = 8, device='png', dpi=300)


##################### f. Crohn ###########################

### tSNE ###

lab = read.table(paste0(workdir, "Supplementary Fig. 20f_source_data2_lab.txt"))[,1]
meta = read.table(paste0(workdir, "Supplementary Fig. 20f_source_data1_tsne.txt"), sep = "\t")
rownames(meta) = meta[,1]
meta = meta[-c(1,2), c(2,3)]
tsne_out = meta
tsne_out = cbind(tsne_out, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")
tsne_out$tSNE_1 = as.numeric(tsne_out$tSNE_1)
tsne_out$tSNE_2 = as.numeric(tsne_out$tSNE_2)

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.3) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20f_tsne.png" ,width = 12, height = 8, device='png', dpi=300)


### UMAP ###
load(paste0(workdir,"Supplementary Fig. 20f_source_data3_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("Umap_1", "Umap_2", "label")

ggplot(umap, aes(x=Umap_1, y=Umap_2, color=label))+
  geom_point(size = 0.3) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20f_umap.png" ,width = 12, height = 8, device='png', dpi=300)


##################### g. Kidney_normal  ###########################

### tSNE ###

load(paste0(workdir, "Supplementary Fig. 20g_source_data3_tsne.Rdata"))
lab = read.table(paste0(workdir, "Supplementary Fig. 20g_source_data2_lab.txt"))[,1]

tsne_out = cbind(tsne_out, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.5) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20g_tsne.png",width = 10, height = 6, device='png', dpi=300)


### UMAP ###

load(paste0(workdir, "Supplementary Fig. 20g_source_data1_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("umap_1", "umap_2", "label")
ggplot(umap, aes(x=umap_1, y=umap_2, color=label)) + 
  geom_point(size = 0.5) +
  theme_bw() +
  xlab("Umap-1") +
  ylab("Umap-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20g_umap.png",width = 10, height = 6, device='png', dpi=300)

##################### h. Kidney_ccRCC  ###########################

### tSNE ###

load(paste0(workdir, "Supplementary Fig. 20h_source_data3_tsne.Rdata"))
lab = read.table(paste0(workdir, "Supplementary Fig. 20h_source_data2_lab.txt"))[,1]

tsne_out = cbind(tsne_out, lab)
colnames(tsne_out) = c("tSNE_1", "tSNE_2", "label")

ggplot(tsne_out, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.5) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20h_tsne.png",width = 10, height = 6, device='png', dpi=300)


### UMAP ###

load(paste0(workdir, "Supplementary Fig. 20h_source_data1_umap.Rdata"))

umap = cbind(umap, lab)
colnames(umap) = c("umap_1", "umap_2", "label")
ggplot(umap, aes(x=umap_1, y=umap_2, color=label)) + 
  geom_point(size = 0.5) +
  theme_bw() +
  xlab("Umap-1") +
  ylab("Umap-2") +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Supplementary Fig. 20h_umap.png",width = 10, height = 6, device='png', dpi=300)



