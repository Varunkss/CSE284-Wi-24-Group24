# CSE 284 plotting & analysis

library(readxl)
library(ggplot2)
library(RColorBrewer)
library(survival)
library(ggpubr)
library(tidyverse)
library(dplyr)
#all samples
library(splitstackshape)
library(Rtsne)
library(ggplot2)
library(umap)
library(readxl)
library(dplyr)
library(gridExtra)
library(survminer)
library(ggpubr)
library(ggfortify)
library(survival)

# load admixutre table
admixture<-read_excel("/Users/tjsears/Code/cse284/AdmixtureTCGA.xlsx")

# load survival table

tcga_survival<-read.table("/Users/tjsears/Code/cse284/Liu2018.TCGA_survival.csv",sep=',',header = T)


# merge tables
final<-merge(admixture,tcga_survival,by.x="patient",by.y="bcr_patient_barcode")

# assign black, white, mixed, or other categories
final$consensus_ancestry

# plot histogram of race for BRCA
temp<-final[final$type=="BRCA",]
temp_plot<-data.frame(table(temp$consensus_ancestry))

#HLA_A$AI<-ifelse(HLA_A$HLA.A1%in%class_I,"AI+","AI-")
ggplot(temp_plot, aes(x=Var1,y=Freq,fill=Var1)) +
  geom_bar(stat = "identity") + 
  ggtitle("BRCA ancestry barplot") +
  xlab("Values") + theme_bw(base_size = 14) +
  ylab("Frequency") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotate x-axis labels
ggsave("/Users/tjsears/Code/cse284/admix_brca_barplot.pdf",width = 9,height = 7)


# plot km curve split by race for BRCA
temp_plot<-temp[temp$consensus_ancestry%in%c("eur","afr","afr_admix"),]
temp_plot<-temp_plot[temp_plot$ajcc_pathologic_tumor_stage!="Stage I"&temp_plot$ajcc_pathologic_tumor_stage!="Stage II",]

temp_plot<-temp_plot[!temp_plot$PFI.time=="MISSING",]
temp_plot$PFI.time<-as.numeric(temp_plot$PFI.time)
temp_plot$PFI<-as.numeric(temp_plot$PFI)

km_trt_fit <- survfit(Surv(PFI.time, PFI) ~ consensus_ancestry, data=temp_plot)
res<- pairwise_survdiff(Surv(PFI.time, PFI) ~ consensus_ancestry, data=temp_plot,p.adjust.method = "none",rho=0) #, p.adjust.method = "none", rho = 0)
res$p.value<-round(res$p.value, digits = 4)
res

p1<-ggsurvplot(km_trt_fit,data=temp_plot,size=1.2,censor.shape="|", censor.size = 2,legend=c("top"),
               pval=F,xlim=c(0,3000),break.x.by=500,ncensor.plot.height=0.25,#risk.table.title="",
               font.x=18,font.y=18,font.legend=10,font.title=18,
               #risk.table = c("absolute"),
               #palette=cols,
               legend.title="",ylim=c(0.5,1),
               title="BRCA ancestry PFS"
               ,xlab="Time in Days",
               ylab="Relapse-Free Survival (%)",
               surv.scale = c("percent"),
               #risk.table.title=""
               )
p1#$plot+annotate(geom = "table", x = 140, y = 0.1, label = (as.data.frame(res$p.value)))
ggsave("/Users/tjsears/Code/cse284/BRCA.pdf",width = 8,height = 8)










# plot histogram of race for BRCA
temp<-final[final$type=="PRAD",]
temp_plot<-data.frame(table(temp$consensus_ancestry))

#HLA_A$AI<-ifelse(HLA_A$HLA.A1%in%class_I,"AI+","AI-")
ggplot(temp_plot, aes(x=Var1,y=Freq,fill=Var1)) +
  geom_bar(stat = "identity") + 
  ggtitle("PRAD ancestry barplot") +
  xlab("Values") + theme_bw(base_size = 14) +
  ylab("Frequency") + theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Rotate x-axis labels
ggsave("/Users/tjsears/Code/cse284/admix_PRAD_barplot.pdf",width = 9,height = 7)


# plot km curve split by race for BRCA
temp_plot<-temp[temp$consensus_ancestry%in%c("eur","afr","afr_admix"),]
#temp_plot$consensus_ancestry[temp_plot$consensus_ancestry=="afr_admix"]<-"afr"
temp_plot<-temp_plot[temp_plot$ajcc_pathologic_tumor_stage!="Stage I"&temp_plot$ajcc_pathologic_tumor_stage!="Stage II",]

temp_plot<-temp_plot[!temp_plot$PFI.time=="MISSING",]
temp_plot$PFI.time<-as.numeric(temp_plot$PFI.time)
temp_plot$PFI<-as.numeric(temp_plot$PFI)

km_trt_fit <- survfit(Surv(PFI.time, PFI) ~ consensus_ancestry, data=temp_plot)
res<- pairwise_survdiff(Surv(PFI.time, PFI) ~ consensus_ancestry, data=temp_plot,p.adjust.method = "none",rho=0) #, p.adjust.method = "none", rho = 0)
res$p.value<-round(res$p.value, digits = 4)
res

p1<-ggsurvplot(km_trt_fit,data=temp_plot,size=1.2,censor.shape="|", censor.size = 2,legend=c("top"),
               pval=F,xlim=c(0,3000),break.x.by=500,ncensor.plot.height=0.25,#risk.table.title="",
               font.x=18,font.y=18,font.legend=10,font.title=18,
               #risk.table = c("absolute"),
               #palette=cols,
               legend.title="",ylim=c(0.5,1),
               title="PRAD ancestry PFS"
               ,xlab="Time in Days",
               ylab="Relapse-Free Survival (%)",
               surv.scale = c("percent"),
               #risk.table.title=""
)
p1#$plot+annotate(geom = "table", x = 140, y = 0.1, label = (as.data.frame(res$p.value)))
ggsave("/Users/tjsears/Code/cse284/PRAD.pdf",width = 8,height = 8)




