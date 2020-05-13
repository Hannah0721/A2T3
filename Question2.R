# Question2
#a
library(tidyverse)
install.packages("WDI")
library(WDI)
WDIsearch("CO2.*capita")

wdi_data <- WDI(indicator=c("EN.ATM.CO2E.PC"),start=2010,end=2010,extra=TRUE)

wdi_data = as_tibble(wdi_data)
glimpse(wdi_data)

wdi_data <- wdi_data %>%
  rename(Emit_CO2percap=EN.ATM.CO2E.PC)

glimpse(wdi_data)

library(readr)
write_csv(wdi_data,"wdi_CO2.csv")
wdi <- read_csv("wdi_CO2.csv")

summary(wdi$Emit_CO2percap)

install.packages("maps")
library(maps)

dat_map <- map_data("world")

install.packages("countrycode")
library(countrycode)

dat_map$ccode<- countrycode(dat_map$region,origin="country.name",destination="wb")
wdi$ccode <- countrycode(wdi$country,origin="country.name",destination="wb")

merged <- full_join(dat_map, wdi, by="ccode")
ggplot(merged,aes(x=long,y=lat,group=group,fill=Emit_CO2percap))+geom_polygon()

#b
install.packages("devtools")
library(devtools)  

install_github("DougLuke/UserNetR")
install.packages("UserNetR")
library(UserNetR)

install.packages("statnet.common")
library(statnet.common)

install.packages("sna")
library(sna)

data(Bali)
op <- par(mar = c(0,0,0,0))
plot(Bali,displaylabels=TRUE,label.cex=0.8,
     pad=0.4,label.col="darkblue") 
par(op)


#c
rolelab <- get.vertex.attribute(Bali,"role") 
plot(Bali,usearrows=FALSE,label=rolelab,displaylabels=T,label.col="darkblue") 
