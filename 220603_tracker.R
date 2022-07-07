setwd("O:/Data/Rene/210906_track/")
files<-list.files(pattern = "track.csv")

### file read in loop

for (k in 1:length(files))
	{
	data_raw<-read.csv(files[1], header = FALSE, skip=2, dec=",", sep=";")



### wells in loop


wells<-levels(as.factor(data_raw[,5]))

for (w in 1:length(wells))
{
		

		well_objects<-subset(data_raw,data_raw[,5]==wells[w])



### object loop = l, 


	init_objects<-subset(well_objects,well_objects[,4]==1)
	
	for (l in 1:length(init_objects[,1]))
		{
		result<-matrix(nrow=max(well_objects[,4]),ncol=length(well_objects[1,]))
		 
### time loop =m		

			
			result[1,]<-as.numeric(init_objects[l,])

			for (m in 2:max(well_objects[,4]))
			{
			
### find nearest value
				
				fol_objects<-subset(well_objects,well_objects[,4]==m)
				distmap<-matrix(nrow=1,ncol=length(fol_objects[,1]))
				for (n in 1:length(fol_objects[,1]))
					{
					sing_fol_objects<-fol_objects[n,]
					distmap[n] <- sqrt((result[m-1,19] - sing_fol_objects[19])^2+ (result[m-1,20] - sing_fol_objects[20])^2)			
					}
				mini<-which.min(distmap)
				
				if (distmap[mini]<2000)
					{
					result[m,]<-as.numeric(fol_objects[mini,])
					}
					else
					{
					result[m,]<-as.numeric(result[m-1,])
					}
				 	
			}
			
			write.table(result,paste(substring(files[k],1,6),"_well_",wells[w],"_cell_",l,".txt",sep=""), row.names=FALSE, sep="\t")
			tiff(paste(substring(files[k],1,6),"_well_",wells[w],"_cell_",l,".tiff",sep=""),width = 350, height = 350, units="px", pointsize = 16)
			plot(result[,16],result[,13],main=paste(substring(files[k],1,6),"_well_",wells[w],"_cell_",l,".txt",sep=""),xlim=c(0,400000),ylim=c(0,40),xlab="total DNA", ylab="sd DNA",
			col=rev(rainbow(14)))
			dev.off()

		}		
	
	}
	}