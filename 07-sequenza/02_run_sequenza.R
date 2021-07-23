
library(sequenza)
chr.list<- c("chr1","chr2","chr3","chr4","chr5","chr6","chr7","chr8","chr9","chr10", "chr11","chr12","chr13","chr14","chr15","chr16","chr17","chr18","chr19", "chr20","chr21","chr22","chrX")
ex1 <- sequenza.extract("sampleid.seqz.bin.gz",gz = TRUE, window = 100000, chromosome.list = chr.list)
CP.ex1 <- sequenza.fit(ex1)
sequenza.results(sequenza.extract = ex1, cp.table = CP.ex1, sample.id = "sampleid", out.dir = ".")
