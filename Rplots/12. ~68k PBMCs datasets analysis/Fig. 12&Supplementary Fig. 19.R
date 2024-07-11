
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/12. ~68k PBMCs datasets analysis/')  

library(ggplot2)
library(paletteer)
library(reshape2)
library(RColorBrewer)
library(pheatmap)

tsne_out = read.table(paste0(workdir, "Fig. 12a_source_data_tsne.tsv"),
                      header = T,sep = "\t")
df = tsne_out[,c(1,2)]
rownames(df) = tsne_out$barcodes
label = tsne_out$celltype
colnames(df) = c("tSNE_1", "tSNE_2")

ggplot(df, aes(x=tSNE_1, y=tSNE_2, color=label)) + 
  geom_point(size = 0.1) +
  theme_bw() +
  xlab("tSNE-1") +
  ylab("tSNE-2") +
  scale_color_manual(values = c(paletteer_d("ggthemes::Tableau_10"),"#2B908F")) +
  theme(text=element_text(size=15,  family="serif",face = 'bold'),
        strip.text = element_text(size=15, family="serif",face = 'bold'),
        legend.text = element_text(size=15, family="serif",face = 'bold'),
        legend.title = element_blank(),
        legend.position = "right",
        legend.key.width=unit(1,"cm"),
        legend.key.height=unit(0.5,"cm"),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  guides(color = guide_legend(ncol =1, override.aes = list(size = 4)))
ggsave(path = workdir, filename = "Fig. 12a",width = 10, height = 6, device='png', dpi=300)

##################### rare cell type ###########################

lines <- readLines(paste0(workdir, "Fig. 12b_source_data_scCAD_res.txt"))
rare_cell_id = c()
for (l in lines) {
  rare_cell_id = c(rare_cell_id, list(strsplit(l,"\t")[[1]]))
}
y_pre = rep("Abundant", nrow(df))
names(y_pre) = tsne_out$barcodes

n = 1
for (i in rare_cell_id) {
  y_pre[i] = rep(paste0("R",n), length(i))
  n = n+1
}

df = cbind(df, y_pre)
colnames(df) = c("tSNE_1", "tSNE_2", "Rlab")

ggplot(df, aes(x=tSNE_1, y=tSNE_2, color=Rlab)) + 
  geom_point(size = 0.1) +
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
ggsave(path = workdir, filename = "Fig. 12b" ,width = 8, height = 6, device='png', dpi=300)

##################### pearson heatmap ###########################

ref_genes = read.csv(paste0(workdir, "Fig. 12c_source_data1_ref_gene.csv"))
load(paste0(workdir, "Fig. 12c_source_data2_subdata.Rdata"))
load(paste0(workdir, "Fig. 12c_source_data3_refdata.Rdata"))
lines <- readLines(paste0(workdir, "Fig. 12b_source_data_scCAD_res.txt"))
rare_cell_id = c()
for (l in lines) {
  rare_cell_id = c(rare_cell_id, list(strsplit(l,"\t")[[1]]))
}

tmp1 = sub_data[, rare_cell_id[[1]]]
tmp2 = sub_data[, rare_cell_id[[4]]]
tmp3 = sub_data[, which(lab=="Dendritic")]
vec1 = apply(tmp1, 1, mean)
vec2 = apply(tmp2, 1, mean)
vec3 = apply(tmp3, 1, mean)
comb_mat = cbind(vec1, vec2, vec3)
for (t in c("DC1", "DC2", "DC3", "DC4", "DC5", "DC6")) {
  print(t)
  ref_tmp = ref_data[, which(ref_lab==t)]
  ref_vec = apply(ref_tmp, 1, mean)
  comb_mat = cbind(comb_mat, ref_vec)
}
colnames(comb_mat) = c("R1", "R4", "DC", "DC1", "DC2", "DC3", "DC4", "DC5", "DC6")
sim = cor(comb_mat)

annotation = data.frame(
  Dataset = factor(c(rep("PBMC", 3), rep("Villani et al.", 6)))
)
rownames(annotation) = rownames(sim)
ann_colors = list(
  Dataset = c("PBMC" = "gray20",
              "Villani et al." = "gray70"))

png(paste0(workdir, "Fig. 12c.png"), width = 8, height = 6, units = 'in', res = 600)
pheatmap(sim, annotation_col = annotation, annotation_row = annotation, 
         annotation_colors = ann_colors, annotation_names_row = F,
         annotation_names_col = F, 
         color =  colorRampPalette(colors = c('#11427C','white','#C31E1F'))(100),
         # color = colorRampPalette(c("white", "firebrick3"))(50),
         show_colnames = T, cluster_col = T, 
         border_color = "white",
         # border=FALSE,
         number_color = "black",
         display_numbers = TRUE, angle_col = "0")
dev.off()

##################### Violin plots ###########################

df = as.data.frame(matrix(nrow = 0, ncol = 4))
unique_g = c()
for (t in unique(ref_genes$Associated.Cell.Population)) {
  ref_g = ref_genes$Gene.ID[which(ref_genes$Associated.Cell.Population == t)][1:5]
  com_g = intersect(ref_g, rownames(sub_data))
  unique_g = c(unique_g, com_g)
  for (g in com_g) {
    tmp_df = cbind(rep("R1", length(rare_cell_id[[1]])),
                   rep(g, length(rare_cell_id[[1]])),
                   rep(t, length(rare_cell_id[[1]])),
                   sub_data[g, rare_cell_id[[1]]])
    rownames(tmp_df) = NULL
    colnames(tmp_df) = c("lab", "gene", "reftype", "count")
    df = rbind(df, tmp_df)
    
    tmp_df = cbind(rep("R4", length(rare_cell_id[[4]])),
                   rep(g, length(rare_cell_id[[4]])),
                   rep(t, length(rare_cell_id[[4]])),
                   sub_data[g, rare_cell_id[[4]]])
    rownames(tmp_df) = NULL
    colnames(tmp_df) = c("lab", "gene", "reftype", "count")
    df = rbind(df, tmp_df)
    
    tmp_df = cbind(rep("Dendritic", length(names(which(lab=="Dendritic")))),
                   rep(g, length(names(which(lab=="Dendritic")))),
                   rep(t, length(names(which(lab=="Dendritic")))),
                   sub_data[g, names(which(lab=="Dendritic"))])
    rownames(tmp_df) = NULL
    colnames(tmp_df) = c("lab", "gene", "reftype", "count")
    df = rbind(df, tmp_df)
    
  }
}
df$count = as.numeric(df$count)
df$gene = factor(df$gene, levels = unique(df$gene))

ggplot(df, aes(factor(lab), count, fill = gene)) +
  geom_violin(scale = "width", adjust = 1, trim = TRUE) +
  scale_y_continuous(expand = c(0, 0), position="right", labels = function(x)
    c(rep(x = "", times = length(x)-2), x[length(x) - 1], "")) +
  facet_grid(rows = vars(gene), scales = "free", switch = "y") +
  theme_cowplot(font_size = 12) +
  theme(legend.position = "none", panel.spacing = unit(0, "lines"),
        plot.title = element_text(hjust = 0.5),
        panel.background = element_rect(fill = NA, color = "black"),
        strip.background = element_blank(),
        strip.text = element_text(face = "bold"),
        strip.text.y.left = element_text(angle = 0)) +
  ggtitle("") + xlab("Cell Types") + ylab("") 
ggsave(path = workdir, filename = "Fig. 12d" ,width = 4, height = 8, device='png', dpi=300)

##################### expression heatmap ###########################

load(paste0(workdir, "Supplementary Fig. 19_source_data1_degs.Rdata"))
load(paste0(workdir, "Supplementary Fig. 19_source_data2_subdata.Rdata"))
lines <- readLines(paste0(workdir, "Fig. 12b_source_data_scCAD_res.txt"))
rare_cell_id = c()
for (l in lines) {
  rare_cell_id = c(rare_cell_id, list(strsplit(l,"\t")[[1]]))
}

idx = setdiff(setdiff(names(which(lab=="Dendritic")), rare_cell_id[[1]]),
              rare_cell_id[[4]])

tl = c(rep("Dendritic", length(idx)),
       rep("R1", length(rare_cell_id[[1]])),
       rep("R4", length(rare_cell_id[[4]])))
names(tl) = c(idx, rare_cell_id[[1]], rare_cell_id[[4]])

tl = sort(tl)
annotation = as.data.frame(tl)
colnames(annotation) = "Types"
annotation$`Types` <- factor(annotation$`Types`, levels = c("Dendritic",
                                                            "R1", "R4"))
ann_colors = list(
  Types = c("Dendritic"=paletteer_d("ggthemes::Tableau_10")[1],
            "R1"=paletteer_d("ggthemes::Tableau_10")[2],
            "R4"=paletteer_d("ggthemes::Tableau_10")[3]))

sub_data = as.matrix(sub_data)
png(paste0(workdir, "Supplementary Fig. 19a.png"), width = 8, height = 16, units = 'in', res = 600)
pheatmap(sub_data[c(deg1[1:50], deg4[1:50]),names(tl)], border_color = NA, cluster_cols = FALSE, 
         annotation_colors = ann_colors, cluster_rows = T, 
         annotation_col = annotation, show_colnames = FALSE, annotation_names_col = TRUE)
dev.off()

###### R3

idx = sample(setdiff(names(which(lab=="CD19+ B")), rare_cell_id[[3]]), 500)
# idx = setdiff(names(which(lab=="CD19+ B")), rare_cell_id[[3]])

tl = c(rep("CD19+ B", length(idx)),
       rep("R3", length(rare_cell_id[[3]])))
names(tl) = c(idx, rare_cell_id[[3]])

tl = sort(tl)
annotation = as.data.frame(tl)
colnames(annotation) = "Types"
annotation$`Types` <- factor(annotation$`Types`, levels = c("CD19+ B",
                                                            "R3"))
ann_colors = list(
  Types = c("CD19+ B"=paletteer_d("ggthemes::Tableau_10")[1],
            "R3"=paletteer_d("ggthemes::Tableau_10")[2]))

png(paste0(workdir, "Supplementary Fig. 19b.png"), width = 8, height = 16, units = 'in', res = 600)
pheatmap(sub_data[deg3[1:100],names(tl)], border_color = NA, cluster_cols = FALSE, 
         annotation_colors = ann_colors,
         annotation_col = annotation, show_colnames = FALSE, annotation_names_col = TRUE)
dev.off()








