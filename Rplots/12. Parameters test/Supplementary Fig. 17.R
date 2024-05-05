
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/12. Parameters test/')  

library(paletteer)
library(ggplot2)

load(paste0(workdir, "Supplementary Fig. 17_source_data.Rdata"))

ggplot(df, aes(x = Method, y = Num, fill=Method)) +
  geom_bar(position="dodge", stat="identity", width=0.8) +
  theme_bw() +
  xlab("") +
  ylab("The number of clusters") +
  scale_fill_manual(values=paletteer_d("ggthemes::Tableau_10")) +
  scale_x_discrete(labels=c("D-Clusters", "M-Clusters"))+
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        axis.title.x = element_text(size=12, family="serif",face = 'bold.italic'),
        axis.text.x = element_text(size=12, family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none",
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  facet_wrap(~Dataset, scales = "free_y")
ggsave(path = workdir, filename = "Supplementary Fig. 17.png",width = 12, height = 8, device='png', dpi=300)


