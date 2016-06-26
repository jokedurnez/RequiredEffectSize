comparison <- read.table("~/Documents/Onderzoek/Stanford/2016_figurePower/HCP_group_effect_sizes/TomVsJoke/comparison.csv",header=TRUE,sep=",")

library(RColorBrewer)
cols <- brewer.pal(7,"Set1")


samplecorr <- sqrt(80)/sqrt(146)

tlab <- 1:86

par(mar=c(10,4,1,1))
plot(comparison$Tom,type="l",xaxt="n", xlab="",col=cols[1],lwd=2,ylab="Cohens D",ylim=c(0,2.5))
axis(2)
lines(comparison$Joke80,col=cols[2],lwd=2)
lines(comparison$Joke186,col=cols[3],lwd=2)
axis(1, at=tlab, labels=FALSE)
text(x=tlab, y=par()$usr[3]-0.05*(par()$usr[4]),
     labels=paste(comparison$Task,comparison$ConName), srt=90, adj=1, xpd=TRUE,cex=0.7)
legend(1,2.5,c("Tom","Joke n=80","Joke n=186"),col=cols[1:3],lwd=2,bty="n")
