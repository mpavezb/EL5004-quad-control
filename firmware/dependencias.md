# Dependencias

Antes de empezar:

* El archivo "firmware/obj/cleanflight_CC3D.hex" corresponde al binario listo para ser cargado a la CC3D
* Para cargar (flashear) la CC3D con el nuevo binario puede utilizar la GUI
de cleanflight (https://github.com/cleanflight/cleanflight-configurator) y usar la opcion "Load Firmware[Local] > Flash Firmware"

Archivos:

A continuación se describen los archivos

# src/main/main.c
* void init(): funcióm que setea las configuraciones y diferentes funcionalidades del quad.

# src/main/mw.c
* void loop(): función que controla dinámicamente el quad.

# src/main/flight/pid.c
* pid_controller: puntero a función de tipo void (*pidControllerFuncPtr)(pidProfile_t *pidProfile, controlRateConfig_t *controlRateConfig, uint16_t max_angle_inclination, rollAndPitchTrims_t *angleTrim, rxConfig_t *rxConfig); Esta función es la que calcula los errores de angulos que son usados por el mixer según la referencia y su posición actual.
*axisPID[]: arreglo con la suma de contribuciones de los bloques P,I y D del controlador PID que deben son calculados para los movimientos throtle/yaw/roll/pitch. el pid

# src/main/flight/mixer.c

* motorMixer_t: struct que guarda los valores de las señales de throtle-pitch-roll-yaw para un motor en particular.
* uint16_t motor[]: arreglo con los valores de las señales que van a los motores una vez que ya se ha realizado el mixing.
* uint16_t servo[]: arreglo con los valores de las señales que van a los servos opcionales una vez que ya se ha realizado el mixing.
* motorMixer_t currentMixer[] : arreglo de motorMixer_t que representa los valores de throtle-pitch-roll-yaw para cada uno de los motores del vehiculo.
* mixer_t: struct que guarda la cantidad de motores utilizados para el mixing, también guarda un puntero a un struct motorMixer_t, y un boolean para habilitar/deshabilitar el uso de servos adicionales a los motores.
* const mixer_t mixers[]: arreglo que contiene las diferentes configuraciones de mixers predeterminandas de cleanflight (e.g. QuadX, Bicopter, Gimbal, Hex+, etc.)
* void mixTable(): toma los errores de angulos calculados por la funcion apuntada por pid_controller y ejecuta el mixing con lo que calcula las acciones que deben tomar los motores. 

# src/main/rx/rc_controls.c
* uint16_t rcCommand[4]: arreglo con los valores de las señales que salen del receiver y que entran a la placa controladora.

# src/main/dirvers/pwm_output.c
* 

# src/main/blackbox/blackbox.c
Manejo del modo y formato en que se guarda la informacion de BlackBox.
