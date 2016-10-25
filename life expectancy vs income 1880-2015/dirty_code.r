library(rvest)
library(xml2)
library(ggplot2)
library(lubridate)
library(stringr)
library(dplyr)
library(tidyr)
library(readr)

#read files
mpg2 <- read.csv ("mpg2.csv.bz2", stringsAsFactors=FALSE, strip.white=TRUE)

# lower case the make column
mpg2$make<- tolower(mpg2$make)

#vclass as factor
mpg2$vclass<- as.factor(sub(",.*$","",mpg2$vclass) %>% 
  str_replace(" -? ?[24]WD","") %>% 
  str_replace("Sport Utility Vehicle", "Sport Utility Vehicles") %>% 
  str_replace("Special Purpose Vehicle", "Special Purpose Vehicles"))

mpg2$eng_dscr<- NULL
mpg2$guzzler<-!is.na(mpg2$guzzler)&mpg2$guzzler=="G"

#get info from table
page <- read_html("https://en.wikipedia.org/wiki/Automotive_industry") %>% 
  html_nodes(xpath= "//*/table[contains(@class, 'wikitable')]") %>% 
  .[[4]] %>% 
  html_table(fill = TRUE)

#ignore the parent owner column
page$`Parent (Owner)` <- NULL
# change the name
names(page) <- c("make", "country")
# lower case the rows
page$make <- tolower(page$make)
page$country <- tolower(page$country)

# join two columns together
join <- inner_join(page,mpg2, by = "make")
#write the csv file
write.csv(subset(join, year >= 2000), "mpg2-clean.csv")

# remove leading whitespace
trimws(join$country)
str(page)

gsub("^ .", "", page$country)


#filter: year greater than 2000
mpg2<- mpg2[mpg2$year >= 2000,]



mpg2(page,mpg2)

str(mpg2)
str(page)

table <- page[2]  
html_nodes(xpath= "//*/table[contains(@class, 'wikitable')]") 

html_structure(page)

<a [href, title]>
  
html_attr(table, "title")
  
head(table)
span class = "flagicon"
a href ="/wiki/Japan"  title = "Japan"

a href title = "Lexus"


#vclass as factor
mpg2$vclass <- as.factor(mpg2$vclass)

mpg2$eng_dscr<- NULL

mpg2$guzzler<-!is.na(mpg2$guzzler)&mpg2$guzzler=="G"


# Instead of manually inputting manufacturer country-of-origin, use the appropriate table on this wikipedia page instead. 
#The alignment won’t be perfect, but you can ignore the manufacturers that don’t have a direct match. 
# (you will still get information on more cars than the original coders did!).

length(mpg2$make[mpg2$make == "cadillac" | mpg2$make == "lincoln"])
                 
length(mpg2$make[mpg2$make == "cadillac" | "lincoln" | "acura", "lexus", "infiniti", "mercedes-benz", "bmw", "bmw alpina", "audi", "jaguar")])

#add country origin
length(mpg2$make[mpg2$make == "cadillac"])  USA
length(mpg2$make[mpg2$make == "lincoln"])   USA
length(mpg2$make[mpg2$make == "acura"])   Japan
length(mpg2$make[mpg2$make == "lexus"])   Japan
length(mpg2$make[mpg2$make == "infiniti"]) Japan
length(mpg2$make[mpg2$make == "mercedes-benz"]) Germany
length(mpg2$make[mpg2$make == "bmw"]) Germany
length(mpg2$make[mpg2$make == "audi"]) Germany
length(mpg2$make[mpg2$make == "bmw alpina"]) Germany
length(mpg2$make[mpg2$make == "jaguar"]) Britain


# write the file
write.csv(subset(mpg2, year >= 2000), "mpg2-clean.csv")



str(mpg2)



unique(mpg2$vclass)
"Midsize-Large Station Wagons"="Large Station Wagons",
"Special Purpose Vehicle 2WD"="Special Purpose Vehicles",
"Special Purpose Vehicle 4WD"="Special Purpose Vehicles",
"Special Purpose Vehicles/2wd"="Special Purpose Vehicles",
"Special Purpose Vehicles/4wd"="Special Purpose Vehicles",
"Sport Utility Vehicle - 2WD"="Sport Utility Vehicles",
"Sport Utility Vehicle - 4WD"="Sport Utility Vehicles",
"Small Pickup Trucks 2WD"="Small Pickup Trucks",
"Small Pickup Trucks 4WD"="Small Pickup Trucks",
"Standard Pickup Trucks 2WD"="Standard Pickup Trucks",
"Standard Pickup Trucks 4WD"="Standard Pickup Trucks",
"Standard Pickup Trucks/2wd"="Standard Pickup Trucks",
"Minivan - 2WD"="Minivans",
"Minivan - 4WD"="Minivans",
"Vans Passenger"="Vans",
"Vans,Cargo Type"="Vans",
"Vans,Passenger Type"="Vans"


mpg2$z <- c("Two Seaters"="Two Seaters",
            "Minicompact Cars"="Minicompact Cars",
            "Subcompact Cars"="Subcompact Cars",
            "Compact Cars"="Compact Cars",
            "Midsize Cars"="Midsize Cars",
            "Large Cars"="Large Cars",
            "Small Station Wagons"="Small Station Wagons",
            "Midsize Station Wagons"="Midsize Station Wagons",
            "Midsize-Large Station Wagons"="Large Station Wagons",
            "Special Purpose Vehicles"="Special Purpose Vehicles",
            "Special Purpose Vehicle 2WD"="Special Purpose Vehicles",
            "Special Purpose Vehicle 4WD"="Special Purpose Vehicles",
            "Special Purpose Vehicles/2wd"="Special Purpose Vehicles",
            "Special Purpose Vehicles/4wd"="Special Purpose Vehicles",
            "Sport Utility Vehicle - 2WD"="Sport Utility Vehicles",
            "Sport Utility Vehicle - 4WD"="Sport Utility Vehicles",
            "Small Pickup Trucks"="Small Pickup Trucks",
            "Small Pickup Trucks 2WD"="Small Pickup Trucks",
            "Small Pickup Trucks 4WD"="Small Pickup Trucks",
            "Standard Pickup Trucks"="Standard Pickup Trucks",
            "Standard Pickup Trucks 2WD"="Standard Pickup Trucks",
            "Standard Pickup Trucks 4WD"="Standard Pickup Trucks",
            "Standard Pickup Trucks/2wd"="Standard Pickup Trucks",
            "Minivan - 2WD"="Minivans",
            "Minivan - 4WD"="Minivans",
            "Vans"="Vans",
            "Vans Passenger"="Vans",
            "Vans,Cargo Type"="Vans",
            "Vans,Passenger Type"="Vans")[mpg2$vclass]




mpg2$guzzler[!is.na(mpg2$guzzler)&mpg2$guzzler=="G"]


mpg2$make_orig<- mpg2$make
mpg2$make_lower <- tolower(mpg2$make)
  mpg2$make_lowerclean <- NA
mpg2$country <- NA
mpg2[mpg2$make_lower == "cadillac", ]$make_lowerclean <- "cadillac"
mpg2[mpg2$make_lower == "cadillac", ]$country <- "USA"
mpg2[mpg2$make_lower == "lincoln", ]$make_lowerclean <- "lincoln"
mpg2[mpg2$make_lower == "lincoln", ]$country <- "USA"


mpg2[mpg2$make_lower == "acura", ]$make_lowerclean <- "acura"
mpg2[mpg2$make_lower == "acura", ]$country <- "Japan"
mpg2[mpg2$make_lower == "lexus", ]$make_lowerclean <- "lexus"
mpg2$trans_dscr<- NULL
mpg2$guzzler<-!is.na(mpg2$guzzler)&mpg2$guzzler=="G"
mpg2[mpg2$make_lower == "lexus", ]$country <- "Japan"
mpg2[mpg2$make_lower == "infiniti", ]$make_lowerclean <- "infiniti"
mpg2[mpg2$make_lower == "infiniti", ]$country <- "Japan"
mpg2[mpg2$make_lower == "mercedes-benz", ]$make_lowerclean <- "mercedes-benz"
mpg2[mpg2$make_lower == "mercedes-benz", ]$country <-   "Germany"
mpg2[mpg2$make_lower == "bmw", ]$make_lowerclean <- "bmw"
mpg2[mpg2$make_lower == "bmw", ]$country <- "Germany"
mpg2[mpg2$make_lower == "audi", ]$make_lowerclean <- "audi"
mpg2[mpg2$make_lower == "audi", ]$country <- "Germany"
mpg2[mpg2$make_lower == "jaguar", ]$make_lowerclean <- "jaguar"
mpg2[mpg2$make_lower == "jaguar", ]$country <- "Britain"
mpg2[mpg2$make_lower == "bmw alpina", ]$make_lowerclean <- "bmw"
mpg2[mpg2$make_lower == "bmw alpina", ]$country <- "Germany"
mpg2 <- mpg2[is.na(mpg2$country) == FALSE, ]
mpg2$eng_dscr<- NULL
mpg2$z <- c("Two Seaters"="Two Seaters","Minicompact Cars"="Minicompact Cars","Subcompact Cars"="Subcompact Cars","Compact Cars"="Compact Cars","Midsize Cars"="Midsize Cars","Large Cars"="Large Cars","Small Station Wagons"="Small Station Wagons","Midsize Station Wagons"="Midsize Station Wagons","Midsize-Large Station Wagons"="Large Station Wagons","Special Purpose Vehicles"="Special Purpose Vehicles","Special Purpose Vehicle 2WD"="Special Purpose Vehicles","Special Purpose Vehicle 4WD"="Special Purpose Vehicles","Special Purpose Vehicles/2wd"="Special Purpose Vehicles","Special Purpose Vehicles/4wd"="Special Purpose Vehicles","Sport Utility Vehicle - 2WD"="Sport Utility Vehicles","Sport Utility Vehicle - 4WD"="Sport Utility Vehicles","Small Pickup Trucks"="Small Pickup Trucks","Small Pickup Trucks 2WD"="Small Pickup Trucks","Small Pickup Trucks 4WD"="Small Pickup Trucks","Standard Pickup Trucks"="Standard Pickup Trucks","Standard Pickup Trucks 2WD"="Standard Pickup Trucks","Standard Pickup Trucks 4WD"="Standard Pickup Trucks","Standard Pickup Trucks/2wd"="Standard Pickup Trucks","Minivan - 2WD"="Minivans","Minivan - 4WD"="Minivans","Vans"="Vans","Vans Passenger"="Vans","Vans,Cargo Type"="Vans","Vans,Passenger Type"="Vans")[mpg2$vclass]
write.csv(subset(mpg2, year >= 2000), "mpg2-clean.csv")
