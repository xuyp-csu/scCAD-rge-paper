
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/1. Benchmarking/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)

df = read_excel(paste0(workdir, "Fig. 2a_source_data.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df[which(df=="NA",arr.ind = T)] = 0

rankmat <- matrix(nrow = 0,ncol = ncol(df))
for (i in 1:nrow(df)) {
  rankmat <- rbind(rankmat, rank(-as.numeric(df[i,]), ties.method='max'))
}
rownames(rankmat) = rownames(df)
colnames(rankmat) = colnames(df)
data_melt <- melt(rankmat)
names(data_melt) = c('Dataset', 'Method', 'Ranking')

ggplot(data_melt, aes(x=Method, y=Ranking, fill=Dataset, color=Dataset)) + 
  geom_dotplot(binaxis='y', stackdir='center',  binwidth = 0.2, stackgroups = TRUE, binpositions="all") +
  xlab("") +
  ylab(expression("Rank of Methods Based on "~F[1]~"score"~" Across Datasets")) +
  scale_y_continuous(breaks = c(1:11))+
  theme(panel.grid.major = element_line(colour="gray"),
        panel.grid.minor = element_line(colour="gray"),
        panel.background = element_blank(),
        panel.border = element_rect(colour="black",fill=NA),
        axis.text.x = element_text(size = 13, family = "serif", face = 'bold'),
        axis.text.y = element_text(size = 13, family = "serif"),
        axis.title.y = element_text(size = 13, family = "serif", face = 'bold'),
        legend.position = "top",
        legend.key = element_rect(fill = "white", color = NA),
        legend.text = element_text(size = 13, family = "serif"))+
  guides(fill = guide_legend(nrow = 3))
ggsave(path = workdir, filename = "Supplementary Fig. 2a.png",width = 12, height = 8, device='png', dpi=300)

df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data1.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df[which(df=="NA",arr.ind = T)] = 0

rankmat <- matrix(nrow = 0,ncol = ncol(df))
for (i in 1:nrow(df)) {
  rankmat <- rbind(rankmat, rank(-as.numeric(df[i,]), ties.method='max'))
}
rownames(rankmat) = rownames(df)
colnames(rankmat) = colnames(df)
data_melt <- melt(rankmat)
names(data_melt) = c('Dataset', 'Method', 'Ranking')

ggplot(data_melt, aes(x=Method, y=Ranking, fill=Dataset, color=Dataset)) + 
  geom_dotplot(binaxis='y', stackdir='center',  binwidth = 0.2, stackgroups = TRUE, binpositions="all") +
  xlab("") +
  ylab(expression("Rank of Methods Based on G-Mean Across Datasets")) +
  scale_y_continuous(breaks = c(1:11))+
  theme(panel.grid.major = element_line(colour="gray"),
        panel.grid.minor = element_line(colour="gray"),
        panel.background = element_blank(),
        panel.border = element_rect(colour="black",fill=NA),
        axis.text.x = element_text(size = 13, family = "serif", face = 'bold'),
        axis.text.y = element_text(size = 13, family = "serif"),
        axis.title.y = element_text(size = 13, family = "serif", face = 'bold'),
        legend.position = "top",
        legend.key = element_rect(fill = "white", color = NA),
        legend.text = element_text(size = 13, family = "serif"))+
  guides(fill = guide_legend(nrow = 3))
ggsave(path = workdir, filename = "Supplementary Fig. 2b.png",width = 12, height = 8, device='png', dpi=300)

df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data2.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df[which(df=="NA",arr.ind = T)] = 0

rankmat <- matrix(nrow = 0,ncol = ncol(df))
for (i in 1:nrow(df)) {
  rankmat <- rbind(rankmat, rank(-as.numeric(df[i,]), ties.method='max'))
}
rownames(rankmat) = rownames(df)
colnames(rankmat) = colnames(df)
data_melt <- melt(rankmat)
names(data_melt) = c('Dataset', 'Method', 'Ranking')

ggplot(data_melt, aes(x=Method, y=Ranking, fill=Dataset, color=Dataset)) + 
  geom_dotplot(binaxis='y', stackdir='center',  binwidth = 0.2, stackgroups = TRUE, binpositions="all") +
  xlab("") +
  ylab(expression("Rank of Methods Based on MCC Across Datasets")) +
  scale_y_continuous(breaks = c(1:11))+
  theme(panel.grid.major = element_line(colour="gray"),
        panel.grid.minor = element_line(colour="gray"),
        panel.background = element_blank(),
        panel.border = element_rect(colour="black",fill=NA),
        axis.text.x = element_text(size = 13, family = "serif", face = 'bold'),
        axis.text.y = element_text(size = 13, family = "serif"),
        axis.title.y = element_text(size = 13, family = "serif", face = 'bold'),
        legend.position = "top",
        legend.key = element_rect(fill = "white", color = NA),
        legend.text = element_text(size = 13, family = "serif"))+
  guides(fill = guide_legend(nrow = 3))
ggsave(path = workdir, filename = "Supplementary Fig. 2c.png",width = 12, height = 8, device='png', dpi=300)


df = read_excel(paste0(workdir, "Supplementary Fig. 1_source_data3.xlsx"))
df = as.data.frame(df)
rownames(df) = df[,1]
df = df[,-1]
df[which(df=="NA",arr.ind = T)] = 0

rankmat <- matrix(nrow = 0,ncol = ncol(df))
for (i in 1:nrow(df)) {
  rankmat <- rbind(rankmat, rank(-as.numeric(df[i,]), ties.method='max'))
}
rownames(rankmat) = rownames(df)
colnames(rankmat) = colnames(df)
data_melt <- melt(rankmat)
names(data_melt) = c('Dataset', 'Method', 'Ranking')

ggplot(data_melt, aes(x=Method, y=Ranking, fill=Dataset, color=Dataset)) + 
  geom_dotplot(binaxis='y', stackdir='center',  binwidth = 0.2, stackgroups = TRUE, binpositions="all") +
  xlab("") +
  ylab(expression("Rank of Methods Based on Kappa Across Datasets")) +
  scale_y_continuous(breaks = c(1:11))+
  theme(panel.grid.major = element_line(colour="gray"),
        panel.grid.minor = element_line(colour="gray"),
        panel.background = element_blank(),
        panel.border = element_rect(colour="black",fill=NA),
        axis.text.x = element_text(size = 13, family = "serif", face = 'bold'),
        axis.text.y = element_text(size = 13, family = "serif"),
        axis.title.y = element_text(size = 13, family = "serif", face = 'bold'),
        legend.position = "top",
        legend.key = element_rect(fill = "white", color = NA),
        legend.text = element_text(size = 13, family = "serif"))+
  guides(fill = guide_legend(nrow = 3))
ggsave(path = workdir, filename = "Supplementary Fig. 2d.png",width = 12, height = 8, device='png', dpi=300)


