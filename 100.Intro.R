

# To extract the attributes (data.frame) from a SpatVector
d<-as.data.frame(v)

## OPERAZIONI SU UN VETTORE
# Per sovrapporre all'immagine vettoriale un riquadro
z<-rast(v)  ## Creo un raster a partire da 'v' in modo che siano salvate le coordinate
dim(z)<-c(2,2)  ## Imposto 4 pixel, che ricorpiranno tutta la grandezza del riquadro
values(z)<-1:4  ## Assegno 4 valori possibili, quindi i pixel avranno colori diversi
names(z)<-'Zone'  ## Assegno il nome dei 4 riquadri (pixel) al posto dei valori numerici (1-4)
z<-as.polygons(z)  ## Trasformo il raster in un vector (4 rettangoli)
plot(v)  ## Grafico della mia immagine vettoriale (punti, linee, poligoni)
plot(z, add=TRUE, border='blue', lwd=5)  ## Aggiungo il riquadro con i bordi blu e di spessore '5'
# Se voglio colorare un riquadro di rosso
z2 <- z[2,]
plot(z2, add=TRUE, border='red', lwd=2, col='red')

# Erase a part of a SpatVector
erese_v<-erase(v,z2)
plot(erese_v)

#Intersect SpatVectors
i<-intersect(v, z2)

# Crop SpatVector
extent<-ext(6, 6.4, 49.7, 50)
pe<-crop(v, e)
plot(v)
plot(extent, add=TRUE, lwd=3, col="red")
plot(pe, col='light blue', add=TRUE)
plot(extent, add=TRUE, lwd=3, border="blue")
plot(i)

# It is common to aggregate (“dissolve”) polygons that have the same value for an attribute of interest
pa<-aggregate(v, by='variabile')
za<-aggregate(z)
plot(za, col='light gray', border='light gray', lwd=5)
plot(pa, add=TRUE, col=rainbow(3), lwd=3, border='white')


###################################################################################################
####################################################################################################
## CRS VECTOR

# We cannot measure the longitude and latitude, but we can estimate them. To do so, you need a
# model of the shape of the earth. Such a model is called a “datum”
# The most commonly used datum is called 'WGS84': World Geodesic System 1984
# The different types of planar coordinate reference systems are referred to as “projections”
# Examples are “Mercator”, “UTM”, “Robinson”, “Lambert”, “Sinusoidal” and “Albers”
# There is not one best projection. Some projections can be used for a map of the whole world;
# other projections are appropriate for small areas only
# Per ispezionare il sistema di riferimento di uno 'SpatVect'
crs(v)

# Per fornire un sistema di riferimento
crdref<-"+proj=longlat +datum=WGS84"  ## Selezioniamo il datum, in quest caso 'WGS84'
v<- vect(nome_file, crs=crdref)  ## Specifichiamo il sistema di riferimento nel vettore
crs(v)  ## Get or set the coordinate reference system of a SpatRaster or SpatVector.
# Per unire 'SpatVector' e dataframe (con stesso numero di righe)
new_v<- vect(nome_file, atts=dataframe, crs=crdref)

# Sometimes we have data without a CRS. In that case we can assign the CRS if we know what it should be
# Per cambiare CRS creo un nuovo dataset a partire dal primo
new_v<-v  ## Copio lo 'SpatVector'
crs(new_v)<-""  ## Rimuovo il CRS
crs(new_v)<-"+proj=longlat +datum=WGS84"  ## Inserisco il CRS che voglio
# One should not use this approach to change the CRS of a data set from what it is to what you want it to be
# Assigning a CRS is like labeling something. You need to provide the label that corresponds to the item

































