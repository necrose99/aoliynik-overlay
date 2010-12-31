update:
	emerge --sync
	layman -S
	eix-update

upgrade: update
	emerge -auDNtv world
	depclean

depclean:
	@emerge -pP|grep -v gcc|grep '/'|grep -v '\s\*'|awk '{print $1}'|xargs emerge -P
	@emerge -p --depclean|grep -v gcc|grep '/'|grep -v '\s\*'|awk '{print $1}'|xargs emerge  --depclean
	@emerge --ask -uDNtv world
	@revdep-rebuild
