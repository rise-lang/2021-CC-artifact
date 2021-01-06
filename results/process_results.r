# matrix multiplication (Fig. 10)
rise_1024 <-read.csv("mm/rise_mm_1024.mlir_times", header = FALSE, sep = ",", dec = ".", stringsAsFactors=FALSE)
rise_1x784_784x128 <- read.csv("mm/rise_mm_1x784_784x128.mlir_times", header = FALSE, sep = ",", dec = ".", stringsAsFactors=FALSE)
rise_1024_opt <-read.csv("mm/rise_mm_1024.mlir_opt_times", header = FALSE, sep = ",", dec = ".", stringsAsFactors=FALSE)
rise_1x784_784x128_opt <- read.csv("mm/rise_mm_1x784_784x128.mlir_opt_times", header = FALSE, sep = ",", dec = ".", stringsAsFactors=FALSE)
affine_1024 <- read.csv("mm/affine_mm_1024.mlir_times", header = FALSE, sep = ",", dec = ".")
affine_1x784_784x128 <- read.csv("mm/affine_mm_1x784_784x128.mlir_times", header = FALSE, sep = ",", dec = ".")
scf_1024 <- read.csv("mm/scf_mm_1024.mlir_times", header = FALSE, sep = ",", dec = ".")
scf_1x784_784x128 <- read.csv("mm/scf_mm_1x784_784x128.mlir_times", header = FALSE, sep = ",", dec = ".")

# name column properly
colnames(rise_1024) <- c("time")
colnames(rise_1x784_784x128) <- c("time")
colnames(rise_1024_opt) <- c("time")
colnames(rise_1x784_784x128_opt) <- c("time")
colnames(affine_1024) <- c("time")
colnames(affine_1x784_784x128) <- c("time")
colnames(scf_1024) <- c("time")
colnames(scf_1x784_784x128) <- c("time")

# remove strings from beginning and end in the rise time files 
rise_1024 <- rise_1024$time[- c(1, 102)]
rise_1x784_784x128 <- rise_1x784_784x128$time[- c(1, 102)]
rise_1024_opt <- rise_1024_opt$time[- c(1, 102)]
rise_1x784_784x128_opt <- rise_1x784_784x128_opt$time[- c(1, 102)]

# find median
median_rise_1024 <- median(unlist(as.numeric(rise_1024)))
median_rise_1x784_784x128 <- median(unlist(as.numeric(rise_1x784_784x128)))
median_rise_1024_opt <- median(unlist(as.numeric(rise_1024_opt)))
median_rise_1x784_784x128_opt <- median(unlist(as.numeric(rise_1x784_784x128_opt)))
median_affine_1024 <- median(unlist(affine_1024))
median_affine_1x784_784x128 <- median(unlist(affine_1x784_784x128))
median_scf_1024 <- median(unlist(scf_1024))
median_scf_1x784_784x128 <- median(unlist(scf_1x784_784x128))

median_rise_1024
median_rise_1x784_784x128
median_rise_1024_opt
median_rise_1x784_784x128_opt
median_affine_1024
median_affine_1x784_784x128
median_scf_1024
median_scf_1x784_784x128

# plot mm results
png("plot_mm_1024_(fig10).png")
barplot(c(median_scf_1024, median_rise_1024, median_affine_1024, median_rise_1024_opt), names.arg = c("SCF", "RISE", "Affine", "RISE opt"))

png("plot_mm_1x784_784x128_(fig10).png")
barplot(c(median_scf_1x784_784x128, median_rise_1x784_784x128, median_affine_1x784_784x128, median_rise_1x784_784x128_opt), names.arg = c("SCF", "RISE", "Affine", "RISE opt"))

################### convolutions (Fig. 12) ###################
# read in data
conv_128 <- read.csv("convolution/conv_128.mlir_times", header = FALSE, sep = ",", dec = ".")
conv_256 <- read.csv("convolution/conv_256.mlir_times", header = FALSE, sep = ",", dec = ".")
conv_512 <- read.csv("convolution/conv_512.mlir_times", header = FALSE, sep = ",", dec = ".")
conv_1024 <- read.csv("convolution/conv_1024.mlir_times", header = FALSE, sep = ",", dec = ".")
conv_2048 <- read.csv("convolution/conv_2048.mlir_times", header = FALSE, sep = ",", dec = ".")
conv_4096 <- read.csv("convolution/conv_4096.mlir_times", header = FALSE, sep = ",", dec = ".")

sep_conv_128 <- read.csv("convolution/separated_conv_128.mlir_times", header = FALSE, sep = ",", dec = ".")
sep_conv_256 <- read.csv("convolution/separated_conv_256.mlir_times", header = FALSE, sep = ",", dec = ".")
sep_conv_512 <- read.csv("convolution/separated_conv_512.mlir_times", header = FALSE, sep = ",", dec = ".")
sep_conv_1024 <- read.csv("convolution/separated_conv_1024.mlir_times", header = FALSE, sep = ",", dec = ".")
sep_conv_2048 <- read.csv("convolution/separated_conv_2048.mlir_times", header = FALSE, sep = ",", dec = ".")
sep_conv_4096 <- read.csv("convolution/separated_conv_4096.mlir_times", header = FALSE, sep = ",", dec = ".")

# name column properly
colnames(conv_128) <- c("time")
colnames(conv_256) <- c("time")
colnames(conv_512) <- c("time")
colnames(conv_1024) <- c("time")
colnames(conv_2048) <- c("time")
colnames(conv_4096) <- c("time")
colnames(sep_conv_128) <- c("time")
colnames(sep_conv_256) <- c("time")
colnames(sep_conv_512) <- c("time")
colnames(sep_conv_1024) <- c("time")
colnames(sep_conv_2048) <- c("time")
colnames(sep_conv_4096) <- c("time")

# find median
median_conv_128 <- median(unlist(conv_128))
median_conv_256 <- median(unlist(conv_256))
median_conv_512 <- median(unlist(conv_512))
median_conv_1024 <- median(unlist(conv_1024))
median_conv_2048 <- median(unlist(conv_2048))
median_conv_4096 <- median(unlist(conv_4096))
median_sep_conv_128 <- median(unlist(sep_conv_128))
median_sep_conv_256 <- median(unlist(sep_conv_256))
median_sep_conv_512 <- median(unlist(sep_conv_512))
median_sep_conv_1024 <- median(unlist(sep_conv_1024))
median_sep_conv_2048 <- median(unlist(sep_conv_2048))
median_sep_conv_4096 <- median(unlist(sep_conv_4096))

# speedup
speedup_128 <- median_conv_128 / median_sep_conv_128
speedup_256 <- median_conv_256 / median_sep_conv_256
speedup_512 <- median_conv_512 / median_sep_conv_512
speedup_1024 <- median_conv_1024 / median_sep_conv_1024
speedup_2048 <- median_conv_2048 / median_sep_conv_2048
speedup_4096 <- median_conv_4096 / median_sep_conv_4096

# plot convolution results
png("plot_conv_(fig12).png")
barplot(c(speedup_128, speedup_256, speedup_512, speedup_1024, speedup_2048, speedup_4096), names.arg = c("128", "256", "512", "1024", "2048", "4096"))