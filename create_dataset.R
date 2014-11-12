library(PKPDdatasets)

data <- dapa_IV_oral
IV_data <- data %>% filter(OCC==1)



IV_data <- IV_data %>% group_by(ID) %>% mutate(DOSE = max(AMT_IV))
mean_IV <- IV_data %>% group_by(TIME, DOSE) %>% summarize(meanDV = exp(mean(log(COBS))))
head(mean_IV)

strip_curves(mean_IV$TIME, mean_IV$meanDV, mean_IV$DOSE, number_terminal_points = 5)
