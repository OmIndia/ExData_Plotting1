if (exists("pow_consume"))
{
print("Exists")

} else {
pow_consume<-read.csv("household_power_consumption.txt",sep=";")

pow_consume[,1] = as.Date(factor(pow_consume[,1]),format = "%d/%m/%Y")

pow_consume_final<-subset(pow_consume,((pow_consume$Date >= "2007-02-01") & (pow_consume$Date <= "2007-02-02")))

# create new date-time field in the final subset

pow_consume_final$newdate <- strptime(paste(pow_consume_final$Date, pow_consume_final$Time), format="%Y-%m-%d %H:%M")  

}

png(filename = "plot4.png",width = 480, height = 480, units = "px", pointsize = 12)

par(mfrow=c(2,2))
plot(pow_consume_final$newdate,(as.numeric(levels(pow_consume_final$Global_active_power))[pow_consume_final$Global_active_power]),type="l", xlab="",ylab="Global Active Power")
plot(pow_consume_final$newdate,(as.numeric(levels(pow_consume_final$Voltage))[pow_consume_final$Voltage]),type="l", xlab="datetime",ylab="Voltage")
with(pow_consume_final,{
      plot(newdate, (as.numeric(levels(pow_consume_final$Sub_metering_1))[pow_consume_final$Sub_metering_1]), type = "n", xlab="",ylab="Energy sub metering")    
      lines(newdate, (as.numeric(levels(pow_consume_final$Sub_metering_1))[pow_consume_final$Sub_metering_1]), col = "black")
      lines(newdate, (as.numeric(levels(pow_consume_final$Sub_metering_2))[pow_consume_final$Sub_metering_2]), col = "red")
      lines(newdate, pow_consume_final$Sub_metering_3, col = "blue")
      legend("topright", pch = c("-"), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
       })
plot(pow_consume_final$newdate,(as.numeric(levels(pow_consume_final$Global_reactive_power))[pow_consume_final$Global_reactive_power]),type="l", xlab="datetime",ylab="Global Reactive Power")

dev.off()

