
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/11. Retina & B_lymphoma datasets analysis/')  

library(ggplot2)
library(paletteer)
library(reshape2)
library(pheatmap)

lab = read.table(paste0(workdir, "Fig. 9a_source_data1_lab.txt"))[,1]
scCAD_res = read.table(paste0(workdir, "Fig. 9a_source_data2_scCAD_res.txt"))[,1]
load(paste0(workdir, "Fig. 9a_source_data3_subdata.Rdata"))

tmp = sub_dat[, which(scCAD_res==paste0("R", 1))]
tmp = apply(tmp, 1, mean)
for (i in c(3,11,12,14,16)) {
  tmp = rbind(tmp, apply(sub_dat[, which(scCAD_res==paste0("R", i))], 1, mean))
}
for (t in paste0("BC",1:10)) {
  idx = which(lab==t)
  tmp = rbind(tmp, apply(sub_dat[, idx], 1, mean))
}
rownames(tmp) = c("R1","R3","R11","R12","R14","R16", paste0("BC",1:10))

png(paste0(workdir, "Fig. 9b.png"), width = 50, height = 40, units = 'mm', res = 600)
pheatmap(cor(t(tmp))[1:6,7:16], fontsize = 5, 
         # treeheight_row = 0, treeheight_col = 0, 
         # cellheight=10, cellwidth = 10,
         treeheight_row = 10,
         treeheight_col = 10)
dev.off()

