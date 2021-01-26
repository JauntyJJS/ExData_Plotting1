library(readr)
library(here)
library(magrittr)
library(dplyr)

power_data <- readr::read_delim(
  file = here::here("household_power_consumption.txt"),
  delim = ";",
  na = c("","NA","?")
)

power_data <- power_data %>%
  dplyr::filter(
    .data$Date %in% c("1/2/2007","2/2/2007")
  ) %>%
  dplyr::mutate(
    Date = as.Date(.data$Date, format = "%d/%m/%Y")
  )

png(here::here("plot1.png"), width=480, height=480)

hist(power_data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="Red")

dev.off()

