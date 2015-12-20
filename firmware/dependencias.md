# Dependencias

Antes de empezar:

* El archivo "firmware/obj/cleanflight_CC3D.hex" corresponde al binario listo para ser cargado a la CC3D
* Para cargar (flashear) la CC3D con el nuevo binario puede utilizar la GUI
de cleanflight (https://github.com/cleanflight/cleanflight-configurator) y usar la opcion "Load Firmware[Local] > Flash Firmware"

Archivos:

A continuación se describen los archivos

# src/main/main.c
* init(): funcióm que setea las configuraciones y diferentes funcionalidades del quad.


# src/main/mw.c
* loop(): función que controla dinámicamente el quad.