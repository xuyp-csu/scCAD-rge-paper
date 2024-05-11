
homedir = 'D:/CSU/Rare cell detection/Github/scCAD-rge-paper/'
workdir = paste0(homedir, 'Rplots/2. Decomposition effectively/')  

library(ggplot2)
library(paletteer)
library(readxl)
library(reshape2)
library(scales)

load(paste0(workdir, "Supplementary Fig. 5~9_source_data1.Rdata"))
init_sts_self_list = sts_self_list
init_sts_prop_list = sts_prop_list
load(paste0(workdir, "Supplementary Fig. 5~9_source_data2.Rdata"))
datlist = c("10X_PBMC", "Airway", "Arc-ME", "Cao", "Chung", "Colliculus","Darmanis", "Deng", "Goolam", "hippocampus", "iLNs", "Koh", "Li", "livers", "Macosko",
            "MacParland", "mammary", "pancrea", "Pollen", "Puram", "Shekhar", "Tonsil", "UUOkidney", "Yang", "Zelsel")

df = as.data.frame(matrix(ncol = 4, nrow = 0))
for (d in datlist) {
  print(d)
  for (i in 1:length(init_sts_self_list[[d]])) {
    tmp_mat = matrix(ncol = 10, nrow = 4)
    
    init_sort_arg = order(init_sts_self_list[[d]][[i]], decreasing = T)
    m_sort_arg = order(sts_self_list[[d]][[i]], decreasing = T)
    
    init_self_distribute = init_sts_self_list[[d]][[i]][init_sort_arg]
    self_distribute = sts_self_list[[d]][[i]][m_sort_arg]
    
    init_prop_distribute = init_sts_prop_list[[d]][[i]][init_sort_arg]
    prop_distribute = sts_prop_list[[d]][[i]][m_sort_arg]
    
    if (length(init_self_distribute)>10){
      init_self_distribute = init_self_distribute[1:10]
      init_prop_distribute = init_prop_distribute[1:10]
    }else{
      init_self_distribute = c(init_self_distribute, rep(0, 10-length(init_self_distribute)))
      init_prop_distribute = c(init_prop_distribute, rep(0, 10-length(init_prop_distribute)))
    }
    
    if (length(self_distribute)>10){
      self_distribute = self_distribute[1:10]
      prop_distribute = prop_distribute[1:10]
    }else{
      self_distribute = c(self_distribute, rep(0, 10-length(self_distribute)))
      prop_distribute = c(prop_distribute, rep(0, 10-length(prop_distribute)))
    }
    
    tmp_mat[1,] = init_self_distribute
    tmp_mat[2,] = self_distribute
    tmp_mat[3,] = init_prop_distribute
    tmp_mat[4,] = prop_distribute
    colnames(tmp_mat) = as.character(1:10)
    rownames(tmp_mat) = c("Init_self","M_self","Init_prop","M_prop")
    tmp_df = melt(tmp_mat)
    tmp_df = cbind(tmp_df, rep(paste(d, "type", i, sep = "_"), 40),
                   rep(d, 40))
    colnames(tmp_df) = c("Method", "Order", "Values", "Type", "Dataset")
    tmp_df$Values = as.numeric(tmp_df$Values)
    df = rbind(tmp_df, df)
  }
  
}

df$Order <- factor(df$Order, levels = as.character(1:10))
t_df = df[which(df$Method %in% c("Init_self", "M_self")),]

for (d in datlist) {
  print(d)
  t_df = df[which(df$Dataset==d), ]
  t_df$Method <- factor(t_df$Method, levels = c("Init_self", "Init_prop", "M_self", "M_prop"))
  t_df$Type = as.character(lapply(t_df$Type, function(x){paste0("Rare cell type ", strsplit(x, split = "_")[[1]][length(strsplit(x, split = "_")[[1]])])}))
  
  
  for (t in unique(t_df$Type)) {
    t_df_ = t_df[which(t_df$Type==t),]
    percentValues = percent(round(t_df_$Values, 2))
    
    ggplot(t_df_, aes(x = Order, y = Values, fill = Method)) +
      geom_bar(position="dodge", stat="identity")+
      geom_text(aes(x = Order, y = Values, group = Method, label=percentValues),
                size=4,
                vjust=-0.5,
                position = position_dodge(width = .9))+
      theme_bw() +
      labs(y = "Proportion", x = "Sorted Clusters") +
      scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
      scale_fill_manual(labels = c(expression(I-clusters~(p["t,i"])),
                                   expression(I-clusters~(p["t,i"]^"'")),
                                   expression(M-clusters~(p["t,i"])),
                                   expression(M-clusters~(p["t,i"]^"'"))), 
                        values=c("#325F8C","#699AC2","#9D917C","#DDD4C7")) +
      theme(text=element_text(size=20,  family="serif",face = 'bold'),
            axis.text.x = element_text(size=20, family="serif",face = 'bold'),
            strip.text.y = element_text(size=20, family="serif",face = 'bold'),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
            legend.text = element_text(size=15, family="serif",face = 'bold'),
            legend.title = element_blank(),
            legend.position = c(.99, .99),
            legend.justification = c("right", "top"),
            legend.box.just = "right",
            legend.key.width=unit(1,"cm"),
            legend.key.height=unit(0.5,"cm"))+
      facet_wrap(~Type)
    ggsave(path = workdir, 
           filename = paste0("Supplementary Fig. 5~9_",d,"_", t, ".png"),
           width = 8, height = 6, device='png', dpi=300,limitsize = FALSE)
    
  }
  
}

