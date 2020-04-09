rm(list = ls())

library(reshape2)
library(tidyverse)
library(dplyr)
library(ggplot2)

setwd('./world-happiness')

db19 <- read.csv('2019.csv', head=TRUE, sep=',', na=NA)
db18 <- read.csv('2018.csv', head=TRUE, sep=',', na=NA)
db17 <- read.csv('2017.csv', head=TRUE, sep=',', na=NA)
db16 <- read.csv('2016.csv', head=TRUE, sep=',', na=NA)
db15 <- read.csv('2015.csv', head=TRUE, sep=',', na=NA)

##modifique los archivos para que tuviesen el mismo encabezado, las variables que no se mantuvieron
##no las tome en cuenta


Y19 <- db19%>%
          select(Overall.rank, Country.or.region, Score, GDP.per.capita, 
                 Social.support, Healthy.life.expectancy, Freedom.to.make.life.choices,
                 Generosity, Perceptions.of.corruption)%>%
          rename('Ranking'=Overall.rank,'Country'=Country.or.region,'GDP'=GDP.per.capita,
                 'Social'=Social.support,'H&L Expectancy'=Healthy.life.expectancy,
                 'Freedom'=Freedom.to.make.life.choices, 'Corruption'=Perceptions.of.corruption)%>%
          add_column(year=2019)

Y18 <- db18%>%
  select(Overall.rank, Country.or.region, Score, GDP.per.capita, 
         Social.support, Healthy.life.expectancy, Freedom.to.make.life.choices,
         Generosity, Perceptions.of.corruption)%>%
  rename('Ranking'=Overall.rank,'Country'=Country.or.region,'GDP'=GDP.per.capita,
         'Social'=Social.support,'H&L Expectancy'=Healthy.life.expectancy,
         'Freedom'=Freedom.to.make.life.choices,'Corruption'=Perceptions.of.corruption)%>%
  add_column(year=2018)


Y17 <- db17%>%
  select(Happiness.Rank, Country, Happiness.Score, Economy..GDP.per.Capita., 
         Family, Health..Life.Expectancy., Freedom,
         Generosity, Trust..Government.Corruption.)%>%
  rename('Ranking'=Happiness.Rank,'Score'=Happiness.Score,'GDP'=Economy..GDP.per.Capita.,
         'Social'=Family,'H&L Expectancy'=Health..Life.Expectancy.,
         'Corruption'=Trust..Government.Corruption.)%>%
  add_column(year=2017)
              
Y16 <- db16%>%
  select(Happiness.Rank, Country, Happiness.Score, Economy..GDP.per.Capita., 
         Family, Health..Life.Expectancy., Freedom,
         Generosity, Trust..Government.Corruption.)%>%
  rename('Ranking'=Happiness.Rank,'Score'=Happiness.Score,'GDP'=Economy..GDP.per.Capita.,
         'Social'=Family,'H&L Expectancy'=Health..Life.Expectancy.,
         'Corruption'=Trust..Government.Corruption.)%>%
  add_column(year=2016)

Y15 <- db15%>%
  select(Happiness.Rank, Country, Happiness.Score, Economy..GDP.per.Capita., 
         Family, Health..Life.Expectancy., Freedom,
         Generosity, Trust..Government.Corruption.)%>%
  rename('Ranking'=Happiness.Rank,'Score'=Happiness.Score,'GDP'=Economy..GDP.per.Capita.,
         'Social'=Family,'H&L Expectancy'=Health..Life.Expectancy.,
         'Corruption'=Trust..Government.Corruption.)%>%
  add_column(year=2015)

db15

###intente hacer un merge m?s limpio pero no pude con ninguna de las otras funciones que encontre

a=merge.data.frame(Y15,Y16, all=TRUE)
b=merge.data.frame(a,Y17, all=TRUE)
c=merge.data.frame(b,Y18, all=TRUE)
db=merge.data.frame(c,Y19, all=TRUE)

##para el analisis pense en mostrar data de argentina, as? como de cada variable.
##veo que los datos tienen diferencias peque?as y son n?meros bajos, por lo que tenemos que buscar plots que sean amigables con eso. 

argentina_df <- db %>% filter(Country == "Argentina")

ggplot(argentina_df, aes(x=Ranking , y=year)) +
  geom_point( size=2 ) + 
  geom_line ( color='blue' ) +
  labs ( title='Ranking', 
         subtitle='for Argentina',
         x='Year', 
         y='Ranking',
         caption='') +
  theme_get() 




