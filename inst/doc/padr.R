## ---- fig.width=7--------------------------------------------------------
library(padr)
coffee

## ---- fig.width=7, message = FALSE---------------------------------------
library(ggplot2); library(dplyr)

coffee %>% 
  thicken('day') %>% 
  group_by(time_stamp_day) %>%
  summarise(day_amount = sum(amount)) %>% 
  pad() %>% 
  fill_by_value(day_amount) %>% 
  ggplot(aes(time_stamp_day, day_amount)) + geom_line()

## ------------------------------------------------------------------------
coffee2 <- coffee %>% thicken('day')
coffee2$time_stamp %>% get_interval
coffee2$time_stamp_day %>% get_interval

## ------------------------------------------------------------------------
data.frame(day_var = as.Date(c('2016-08-12', '2016-08-29'))) %>% thicken

## ------------------------------------------------------------------------
head(emergency)

## ------------------------------------------------------------------------
emergency %>% filter(title == 'EMS: OVERDOSE') %>% 
  thicken('day', 
          start_val = as.POSIXct('2015-12-11 08:00:00', tz = 'EST'),
          colname = 'daystart') %>% 
  group_by(daystart) %>% 
  summarise(nr_od = n()) %>% 
  head

## ------------------------------------------------------------------------
account <- data.frame(day     = as.Date(c('2016-10-21', '2016-10-23', '2016-10-26')),
                      balance = c(304.46, 414.76, 378.98))
account %>% pad

## ------------------------------------------------------------------------
account %>% pad %>% tidyr::fill(balance)

## ------------------------------------------------------------------------
account %>% pad('hour', start_val = as.POSIXct('2016-10-20 22:00:00')) %>% head

## ---- warning=FALSE------------------------------------------------------
padded_groups <- emergency %>% thicken('day') %>%
  count(time_stamp_day, title) %>% 
  pad(group = 'title')

## ------------------------------------------------------------------------
counts <- data.frame(x = as.Date(c('2016-11-21', '2016-11-23',  '2016-11-24')),
                     y = c(2, 4, 4))

counts %>% pad() %>% fill_by_value(y, value = 42)
counts %>% pad() %>% fill_by_function(y, fun = mean)
counts %>% pad() %>% fill_by_prevalent(y)

## ---- fig.width = 7------------------------------------------------------
dehydration_day <- emergency %>% 
  filter(title == 'EMS: DEHYDRATION') %>% 
  thicken(interval = 'day') %>% 
  group_by(time_stamp_day) %>% 
  summarise(nr = n()) %>% 
  pad() %>% 
  fill_by_value(nr)
ggplot(dehydration_day, aes(time_stamp_day, nr)) +
  geom_point() +
  geom_smooth()

