## ---- message = FALSE, warning= FALSE------------------------------------
library(lubridate)
start_val <- ymd_hms('2016-03-25 08:15:00', tz = 'CET')
seq(start_val, by = 'day', length.out = 4) 
seq(start_val, by = 'DSTdays', length.out = 4)

## ------------------------------------------------------------------------
seq(start_val, by = 'week', length.out = 2)

## ------------------------------------------------------------------------
seq(start_val, by = '7 DSTdays', length.out = 2)

## ------------------------------------------------------------------------
library(padr)
to_pad <- data.frame(dt = seq(ymd_hms('20160202 145312', tz = 'CET'),
                                      length.out = 2, by = 'day'))
pad(to_pad, start_val = ymd_hms('20160201 145312', tz = 'EST'))

