
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/6. intestine dataset analysis/')  

library(paletteer)
library(Rtsne)
library(pheatmap)

scCAD_res = read.table(paste0(workdir, "Fig. 5a_source_data2_scCAD_res.txt"))[,1]
load(paste0(workdir,"Fig. 5b_source_data1_scCAD_degs.Rdata"))

deg2 = rownames(degs[[2]])[which(degs[[2]]$avg_log2FC>=1.5)]

scCAD_res_R2 = scCAD_res
scCAD_res_R2[which(scCAD_res_R2!="R2")] = "Abundant"

id = sample(which(scCAD_res_R2=="Abundant"), 500, replace = FALSE)

load(paste0(workdir,"Fig. 5c_source_data1_subdata.Rdata"))

tmp_lab = scCAD_res_R2[c(id,which(scCAD_res_R2=="R2"))]
sub_dat = sub_dat[, order(tmp_lab)]
tmp_lab = tmp_lab[order(tmp_lab)]
names(tmp_lab) = colnames(sub_dat)

ann_colors = list(
  Types = c(Abundant="#BAB0ACFF",
            R2=paletteer_d("ggthemes::Tableau_10")[2]))

annotation = as.data.frame(tmp_lab)
colnames(annotation) = "Types"
annotation$`Types` <- factor(annotation$`Types`, levels = c("Abundant","R2"))

png(paste0(workdir, "Fig. 5c.png"), width = 80, height = 150, units = 'mm', res = 600)
pheatmap(sub_dat, border_color = NA, cluster_cols = FALSE, 
         annotation_colors = ann_colors, fontsize = 5, 
         show_rownames = FALSE,
         annotation_col = annotation, show_colnames = FALSE, annotation_names_col = TRUE,
         treeheight_row = 0, treeheight_col = 0, legend = F)
dev.off()

