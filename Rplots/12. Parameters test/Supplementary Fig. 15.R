
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/12. Parameters test/')  

library(paletteer)
library(ggplot2)

load(paste0(workdir, "Supplementary Fig. 15_source_data.Rdata"))

ggplot(data=combine_df, aes(x=Distence, y=Group, fill=Group)) +
  geom_density_ridges2(scale = 0.5) +
  theme_ridges() +
  theme_bw() +
  stat_density_ridges(quantile_lines = TRUE, quantiles = 0.5, size = 1, jittered_points = TRUE, position = "raincloud",
                      alpha = 0.7, scale = 0.5) +
  scale_color_manual(values = paletteer_d("ggthemes::Tableau_10"))+
  scale_fill_manual(values = paletteer_d("ggthemes::Tableau_10"))+
  xlab("") +
  ylab("") +
  theme(text=element_text(size=20,  family="serif",face = 'bold'),
        strip.text = element_text(size=20, family="serif",face = 'bold'),
        legend.position = "none",
        panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
  facet_wrap(~Dataset, scales = "free_x")

ggsave(path = workdir, filename = "Supplementary Fig. 15.png",width = 18, height = 12, device='png', dpi=300)



