
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/2. Decomposition effectively/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)
library(scales)

load(paste0(workdir, "Supplementary Fig. 3_source_data.Rdata"))

res_mat = as.data.frame(res_mat)
res_mat$Overlap = as.numeric(res_mat$Overlap)
mean_ARI = aggregate(ARI ~ Error_rate, data = NMIARI, FUN = mean)
ggplot() +
  geom_boxplot(data=res_mat, aes(x = Error_rate, y = Overlap, fill = Method),
               width = 0.5, outlier.shape = NA)+
  geom_line(data = mean_ARI, aes(x=Error_rate, y=ARI, group=1),stat="identity",size=1)+
  theme_bw() +
  labs(y = "Overlap Rate", x = "Error Rate") +
  scale_fill_manual(labels = c("HIGs",  "HVGs",  "scCAD"), values=paletteer_d("ggthemes::Tableau_10")) +
  scale_y_continuous(sec.axis=sec_axis(~.*(max(mean_ARI$ARI)),name="ARI"), labels = scales::percent_format(accuracy = 1))+
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        axis.text.x = element_text(size=20, family="serif",face = 'bold'),
        strip.text.y = element_text(size=20, family="serif",face = 'bold'),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())
ggsave(path = workdir, filename = "Supplementary Fig. 3.png",width = 8, height = 6, device='png', dpi=300)

