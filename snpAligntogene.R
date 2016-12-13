#extract snp flank sequence to make a fasta file for BWA alignment
setwd("/Users/zhanghuairen/600Ksnp/")
library(stringr)
da=read.csv(file="chr1.csv",header = T) #snp chip annotation file
head(da)
sink('snp_marker_seq.fa')
for (i in 1:nrow(da)){
  Frank_seq=unlist(str_split(da$Flank[i],"\\[.*\\]")) #split the seq with []
  cat(str_c(">",paste(da$Probe.Set.ID[i],da$Physical.Position[i],sep="|")))
  cat("\n")
  cat(paste(Frank_seq[1],Frank_seq[2],sep=""))
  cat("\n")
}
sink()
######using BWA to create a index file for align#
system("bwa index gene2.fasta -p gene2 ")
######using BWA to align snp marker frank sequence to gene sequence 
system("bwa mem gene2.fasta snp_marker_seq.fa > snpMarke_align.sam")
#####using samtools to extract the algined sequence 
system("samtools view -F 4 snpMarke_align.sam > snpMarkerFiltered.sam")
system("wc -l  snpMarkerFiltered.sam ")

