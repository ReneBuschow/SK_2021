

wells<-c("C","P","S","PS")


plot<-matrix(nrow=500, ncol=14)


for(j in 1:length(wells))
{

setwd(paste("T:/Data/Rene/210927_sarah/211014/",wells[j],sep=""))

files<-list.files(pattern = ".txt")



## area average
data_area<-matrix(nrow=length(files), ncol=14)

for(i in 1:length(files))

{
data_raw<-read.table(files[i], header = TRUE, dec=".", sep="\t")

if (max(data_raw[,3])>60)
{next}





else {


data_area[i,1]<-mean(subset(data_raw[,3],data_raw[,5]=="1"))
data_area[i,2]<-mean(subset(data_raw[,3],data_raw[,5]=="2"))
data_area[i,3]<-mean(subset(data_raw[,3],data_raw[,5]=="3"))
data_area[i,4]<-mean(subset(data_raw[,3],data_raw[,5]=="4"))
data_area[i,5]<-mean(subset(data_raw[,3],data_raw[,5]=="5"))
data_area[i,6]<-mean(subset(data_raw[,3],data_raw[,5]=="6"))
data_area[i,7]<-mean(subset(data_raw[,3],data_raw[,5]=="7"))
data_area[i,8]<-mean(subset(data_raw[,3],data_raw[,5]=="8"))
data_area[i,9]<-mean(subset(data_raw[,3],data_raw[,5]=="9"))
data_area[i,10]<-mean(subset(data_raw[,3],data_raw[,5]=="10"))
data_area[i,11]<-mean(subset(data_raw[,3],data_raw[,5]=="11"))
data_area[i,12]<-mean(subset(data_raw[,3],data_raw[,5]=="12"))
data_area[i,13]<-mean(subset(data_raw[,3],data_raw[,5]=="13"))
data_area[i,14]<-mean(subset(data_raw[,3],data_raw[,5]=="14"))
}}

tiff(paste("211012_", wells[j],"_dens_500.tiff", sep=""),width = 200, height = 1200, units="px")
plot_area<-data_area[order(rowSums(data_area[,]),decreasing=FALSE),]
ploti<-plot_area[,]

plot<-na.omit(ploti)
## write.table(plot,paste(wells[j],".txt",sep=""),sep="\t")
image(t(plot),useRaster=TRUE,zlim=c(0,60),col=topo.colors(24))
dev.off()
rm(plot)
}




