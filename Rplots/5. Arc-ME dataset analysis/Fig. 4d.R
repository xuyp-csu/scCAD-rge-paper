
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/5. Arc-ME dataset analysis/') 

library(ggplot2)
library(paletteer)
library(reshape2)
library(RColorBrewer)

load(paste0(workdir, "Fig. 4a_source_data2_lab.Rdata"))
load(paste0(workdir,"Fig. 4d_source_data1_degs.Rdata"))
load(paste0(workdir,"Fig. 4d_source_data2_subdata.Rdata"))
scCAD_res = read.table(paste0(workdir, "Fig. 4c_source_data_scCAD_res.txt"))[,1]

deg1 = rownames(degs[[1]])[1:3]
deg2 = rownames(degs[[2]])[1:2]
deg3 = rownames(degs[[3]])[1:3]
deg4 = rownames(degs[[4]])[1:3]
deg5 = rownames(degs[[5]])[1:3]
deg6 = rownames(degs[[6]])[1:2]
deg7 = rownames(degs[[7]])[1:3]

df = data.frame()
for (g in c(deg1,deg2,deg3,deg4,deg5,deg6,deg7)) {
  tmp_df = data.frame()
  clu = c()
  for (t in setdiff(unique(scCAD_res), "Abundant")) {
    idx = which(scCAD_res==t)
    tmp = as.data.frame(sub_dat[g,idx])
    rownames(tmp) = NULL
    colnames(tmp) = "Expression"
    tmp_df = rbind(tmp_df,tmp)
    clu = c(clu, rep(t, length(idx)))
  }
  for (t in unique(lab)) {
    idx = which(lab==t)
    tmp = as.data.frame(sub_dat[g,idx])
    rownames(tmp) = NULL
    colnames(tmp) = "Expression"
    tmp_df = rbind(tmp_df, tmp)
    clu = c(clu, rep(t, length(idx)))
  }
  
  tmp_df = cbind(tmp_df, clu, rep(g,nrow(tmp_df)))
  rownames(tmp_df) = NULL
  colnames(tmp_df) = c("Expressions","Clusters","Genes")
  
  df = rbind(df, tmp_df)
}

df$Genes <- factor(df$Genes, levels = unique(df$Genes))
tdf = rep("A", nrow(df))
tdf[which(df$Genes %in% deg2)] = "B"
tdf[which(df$Genes %in% deg3)] = "C"
tdf[which(df$Genes %in% deg4)] = "D"
tdf[which(df$Genes %in% deg5)] = "E"
tdf[which(df$Genes %in% deg6)] = "F"
tdf[which(df$Genes %in% deg7)] = "G"
df = cbind(df, tdf)
colnames(df)[4] = "gClusters"

ggplot(data = df, aes(x = Expressions, y = Clusters, fill = gClusters)) +
  geom_violin(scale = 'width',
              trim = TRUE,
              width = 0.5,
              linewidth = 0) +
  theme_bw() +
  scale_fill_manual(values = paletteer_d("ggthemes::Tableau_10")) +
  scale_y_discrete(limits = rev(c("R1", "R2", "R3","R4", "R5", "R6", "R7", names(table(lab)))),
                   name = "") +
  facet_grid(cols = vars(Genes), scales = 'free') +
  xlab("")+
  theme(
    text = element_text(size=5,  family="sans"),
        legend.position = "none",
        axis.title.x=element_blank(),
        axis.text.x.bottom = element_blank(),
        axis.ticks = element_blank(),
        strip.text.x = element_text(size=5,  family="sans", angle = 90, hjust = 0),
        strip.background = element_blank(),
        panel.border = element_blank(), panel.spacing = unit(1, "mm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Fig. 4d.pdf",width = 65, height = 90, units = "mm",
       dpi=300)

  