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

# src/main/flight/pid.c
* pid_controller: puntero a función de tipo void (*pidControllerFuncPtr)(pidProfile_t *pidProfile, controlRateConfig_t *controlRateConfig, uint16_t max_angle_inclination, rollAndPitchTrims_t *angleTrim, rxConfig_t *rxConfig); Esta función es la que calcula los errores de angulos que son usados por el mixer según la referencia y su posición actual.

# src/main/flight/mixer.c

* mixers: struct de mixer_t
* mixTable(): toma los errores de angulos calculaods por la funcion apuntada por pid_controller y ejecuta el mixing con lo que calcula las acciones que deben tomar los motores. 

