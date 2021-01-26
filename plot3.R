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
    Date = as.Date(.data$Date, format = "%d/%m/%Y"),
  ) %>%
  dplyr::mutate(
    DateTime = as.POSIXct(paste(.data$Date, .data$Time))
  )

png(here::here("plot3.png"), width=480, height=480)

with(power_data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)",
       xlab="")
  lines(Sub_metering_2~DateTime,
        col='Red')
  lines(Sub_metering_3~DateTime,
        col='Blue')
})

legend("topright",
       col=c("black", "red", "blue"),
       lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
