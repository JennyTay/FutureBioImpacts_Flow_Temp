
load("elv_comid.RData")
load("tmp_metrics_change.RData")


data <- left_join(chng, elv, by = "COMID")
head(data)

ggplot(data = data, mapping = aes(x = ElevCat, y = avg))+
  geom_point()+
  geom_vline(xintercept = c(750, 500))+
  geom_hline(yintercept = c(2.5, 2.7, 2.6, 2.8, 3, 3.1))



high_elv_low_temp <- data %>% 
  filter(max>2.5 & max<2.7& ElevCat>750)
plot(high_elv_low_temp$ElevCat, high_elv_low_temp$max)

high_elv_high_temp <- data %>% 
  filter(max>3 & ElevCat>750)
plot(high_elv_high_temp$ElevCat, high_elv_high_temp$max)

high_elv_mid_temp <- data %>% 
  filter(max>2.8 & max<3& ElevCat>750)
plot(high_elv_mid_temp$ElevCat, high_elv_mid_temp$max)

mid_elv_low_temp <- data %>% 
  filter(max<2.5 & ElevCat>750)
plot(mid_elv_low_temp$ElevCat, mid_elv_low_temp$max)

low_elv_high_temp <- data %>% 
  filter(max>3.1 & ElevCat<=750)
plot(low_elv_high_temp$ElevCat, low_elv_high_temp$max)

low_elv_low_temp <- data %>% 
  filter(max<2.6 & ElevCat<=500)
plot(low_elv_low_temp$ElevCat, low_elv_low_temp$max)

low_elv_mid_temp <- data %>% 
  filter(max<3 & ElevCat<=500)
plot(low_elv_mid_temp$ElevCat, low_elv_mid_temp$max)

c <-high_elv_mid_temp

ggplot(data = c, aes(col=c$min)) +
  geom_sf(data = wtrshd_bndry, fill = "white", color = gray(.3), lwd = 1) +
  geom_sf()+
  scale_color_gradientn(colours = myPalette(100), limits = c(min(c$max), max(c$max)))+
  labs(col = "°C") +  
  theme(panel.grid.major=element_line(colour="transparent"),panel.background = element_blank(),
        axis.text = element_blank(),axis.ticks = element_blank(),
        text = element_text(size=30))
