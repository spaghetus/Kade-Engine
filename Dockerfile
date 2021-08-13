FROM ubuntu
VOLUME [ "/src" ,"/out" ]
WORKDIR /src
RUN apt-get update && \
	apt-get install -y software-properties-common && \
	add-apt-repository ppa:haxe/releases -y && \
	apt-get update && \
	apt-get install neko tar gcc-7 g++-7 gcc-7-multilib g++-7-multilib -y && \
	rm -rf /var/apt/lists
RUN apt-get update && apt-get install -y wget && rm -rf /var/apt/lists
ENV HAXE_INSTALLDIR=/haxe
ENV HAXELIB_ROOT=/haxelib
RUN wget https://github.com/HaxeFoundation/haxe/releases/download/4.1.5/haxe-4.1.5-linux64.tar.gz && \
	mkdir $HAXE_INSTALLDIR && \
	tar -xf haxe-4.1.5-linux64.tar.gz -C $HAXE_INSTALLDIR && \
	rm haxe-4.1.5-linux64.tar.gz
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HAXE_INSTALLDIR/haxe_20201231082044_5e33a78aa"
RUN mkdir $HAXELIB_ROOT && haxelib setup $HAXELIB_ROOT
RUN haxelib install lime 7.9.0 && \
	haxelib install openfl && \
	haxelib install flixel
RUN yes | haxelib run lime setup flixel
RUN haxelib run lime setup && \
	haxelib install flixel-tools && \
	haxelib install flixel-addons && \
	haxelib install flixel-ui && \
	haxelib install hscript && \
	haxelib install newgrounds
RUN apt-get update && apt-get install -y git && rm -rf /var/apt/lists
RUN haxelib git faxe https://github.com/uhrobots/faxe && \
	haxelib git polymod https://github.com/larsiusprime/polymod.git && \
	haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc && \
	haxelib git extension-webm https://github.com/KadeDev/extension-webm
RUN ln -s $(which g++-7) /bin/g++
RUN haxelib install linc_luajit && \
	haxelib install actuate
RUN haxelib list
CMD haxelib run lime build html5
