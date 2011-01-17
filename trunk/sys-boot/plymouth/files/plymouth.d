#!/sbin/runscript

depend() {
	before xdm
}

start() {

	if [ "$(pidof plymouth)" ] || [ "$(pidof plymouthd)" ] ; then
         /bin/plymouth --quit &>/dev/null
         chvt 7
        fi
	return 0
}

stop() {

	/sbin/plymouthd
        /bin/plymouth --show-splash
	return 0
}

