setwd("Z:/Data/Sarah/Stellaris/220617_cropped/NCAPH2/Work/")

files<-list.files(pattern = ".txt")

	for (n in 1:length(files))

		{

		data_raw<-read.table(files[n], header = FALSE, skip=1, dec=",", sep="")
		data_row1<-as.numeric(data_raw[,1])
		data_row2<-as.numeric(data_raw[,2])
		data_row3<-as.numeric(data_raw[,3])
		data_row4<-as.numeric(data_raw[,4])

	help(plot)
		spearcor<-cor.test(data_row3,data_row4,method="spearman")

		tiff(paste(files[n],"_profile.tiff",sep=""),height=300,width=300,units="px")
		plot(data_row1*0.091,data_row2,type="l",col="cyan",xlab="Distance [µm]",ylim=c(0,250),ylab="Fluorescence Intensity",lwd=2.0)
		lines(data_row1*0.091,data_row3,col="red",lwd=2.0)
		lines(data_row1*0.091,data_row4,col="green",lwd=2.0)

		text(x=0.4*(max(data_row1*0.091)),y=230,labels=  paste("Rho=", round(as.numeric(spearcor[4]),2),   "  p=",    round(as.numeric(spearcor[3]),4),   sep="")    )
		dev.off()		


		}