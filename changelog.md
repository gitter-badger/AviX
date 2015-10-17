Mudanças feitas pelo AviX no Ubuntu:

	Sudo sem senha, por conta do script ser muito extenso, seria necessário digitar a senha de administrador várias vezes.

	Usuário padrão adicionado ao grupo "audio", para que seja possível usar o servidor de áudio Jack com a menor latência possível.

	Desativadas as entradas de código fonte dos repositórios padrão, para que seja mais rápido atualizar o cachê do APT.

	Ativado o repositório de Parceiros da Canonical.

	APT configurado para auto aceitar o termos de serviço dos pacotes:
		ttf-mscorefonts-installer
		oracle-java9-installer

	Repositórios do Launchpad adicionados ao sistema:
		Graphics drivers PPA(NVIDIA) #TRUSTY #VIVID #WILY
		Oibaf graphics drivers PPA(Intel) #TRUSTY #VIVID #WILY
		Numix PPA(Tema de ícones) #TRUSTY #VIVID #WILY
		Nemo PPA(WebUpd8)(Gerenciador de arquivos) #TRUSTY #VIVID #WILY TMP_FIX
		Folder color PPA(Pastas coloridas no gerenciador de arquivos) #TRUSTY #VIVID #WILY
		Simple screen recorder PPA(Gravador de tela) #TRUSTY #VIVID #WILY TMP_FIX
		Oracle Java PPA(WebUpd8) #TRUSTY #VIVID #WILY
		GIMP extras PPA #TRUSTY #VIVID #WILY
		LibreOffice PPA #TRUSTY #VIVID #WILY
		Haguichi PPA(VPN) #TRUSTY #VIVID# #WILY

	Repositórios extra:
		KXStudio repositories(Aplicativos de áudio e vídeo) #TRUSTY #VIVID #WILY
		Vertex theme repository(Tema GTK) #TRUSTY #VIVID #WILY TMP_FIX
		Spotify repository(Tocador de música online) #ALL
		Syncthing repository(Sincronização local de arquivos) #ALL
		VirtualBox repository(Virtualização) #TRUSTY #VIVID #WILY TMP_FIX

	Instalado kernel "lowlatency-lts-utopic" no Ubuntu Trusty e o kernel "lowlatency" no Ubuntu Vivid e no Ubuntu Wily.
	
	Kernel genérico completamente removido.

	Instalado o pacote "ubuntu-extras-keyring" no Ubuntu Trusty.

	Repositórios atualizados.

	Sistema atualizado.

	Aplicativos do núcleo principal do sistema:
		q4wine (Gerenciador de prefixos do Wine) 
		winbind (Serviço de usuários e grupos do Wine)
		wineasio (Driver WineASIO para o servidor de áudio Jack)
		playonlinux (Gerenciador de prefixos do Wine)
		cadence (Painel das configurações de áudio do sistema)
		pulseaudio-module-jack (Módulo do Jack para o servidor de som PulseAudio)
		indicator-cpufreq (Indicador de escala de frequência do processador)
		oracle-java9-installer (Java proprietário da Oracle)
		icedtea-plugin (Plugin do Java para navegadores)
		alsa-firmware (Drivers de áudio complementares, suporta uma grande quantidade de interfaces)

	Aplicativos para aprimorar a experiência de uso do desktop:
		nemo (Gerenciador de arquivos)
		nemo-dropbox (Integradação do Dropbox para o gerenciador de arquivos)
		nemo-emblems (Emblemas para as pastas do gerenciador de arquivos)
		nemo-share (Compartilhamento de pastas através da rede local SAMBA/CIFS)
		folder-color-nemo (Pastas coloridas no gerenciador de arquivos)
		vertex-theme (Tema GTK)
		numix-icon-theme-circle (Tema de ícones)
		deluge-gtk (Cliente torrent)
		python-libtorrent (Dependência do deluge-gtk)
		parole (Tocador de mídia)
		qasmixer (Mixer para todas as interfaces de áudio)
		spotify-client (Tocador de música online)
		libreoffice-style-tango (Tema de ícones para o LibreOffice)
		shutter (Captura de tela)
		vinagre (Acesso remoto)
		p7zip-rar (Descompactador de arquivos)
		rygel-preferences (Configurações do compartilhamento de mídia na rede local)
		skype (Cliente VoIP)
		gtk2-engines-pixbuf:i386 (Engine GTK Pixbuf)
		unity-gtk2-module:i386 (Módulo do Unity para programas de 32 bits)
		pyrenamer (Renomeador de arquivos em massa)
		filezilla (Cliente FTP)
		diodon (Gerenciador da área de transferência)
		liferea (Leitor de notícias)
		syncthing (Sincronização local de arquivos)
		haguichi (Interface gráfica para o LogMeIn-Hamachi/VPN)
		preload (Daemon auto adaptável para o pré carregamento de aplicativos)
		gshare (Compartilhamento de arquivos na rede local SAMBA/CIFS)
		undistract-me (Notificações para comandos longos no terminal)
		pidgin (Comunicador instantâneo com suporte multi-protocolo)
		pidgin-skype (Suporte ao protocolo do Skype para o Pidgin)
		pidgin-facebook (Suporte ao novo protocolo do Facebook para o Pidgin)

	Aplicativos de configuração do sistema:
		system-config-samba (Configurações do servidor de compartilhamento na rede local SAMBA)
		synaptic (Gerenciador de pacotes do sistema)
		deborphan (Listador de pacotes órfãos)
		bleachbit (Limpador do sistema)
		grsync (Interface gráfica para sincronização de arquivos através do protocolo rsync)
		modem-manager-gui (Gerenciador de modems USB)

	Ferramentas de desenvolvimento do sistema:
		git (Gerenciador de repositórios de desenvolvimento)
		checkinstall (Criador de pacotes no formato do Debian/Ubuntu)
		gparted (Gerenciador de discos)
		gdebi (Instalador de pacotes)
		gufw (Firewall)
		unetbootin (Criador de pendrives de instalação para sistemas Linux)
		sparkleshare (Sincronizador de arquivos para repositórios de desenvolvimento)
		virtualbox(Ubuntu Wily)(Virtualização)
		virtualbox-5.0(Ubuntu Trusty e Ubuntu Vivid)(Virtualização)

	Aplicativos multimídia:
		acetoneiso (Montador de imagens de disco com suporte à diversos formatos)
		gimp (Editor de imagens)
		gimp-plugin-registry (Plugins adicionais para o editor de imagens GIMP)
		inkscape (Editor de imagens vetoriais)
		simplescreenrecorder (Gravador de tela)
		blender (Criação 3D, composição e edição de vídeos)
		openshot (Editor de vídeos)
		kdenlive (Editor de vídeos)
		krita (Editor de imagens, desenho)
		kde-l10n-ptbr (Idioma português brasileiro para o KDEnLive e Krita)
		handbrake (Ripador de DVDs)
		brasero (Gravador de discos)
		asunder (Ripador de CDs)
		ffmpeg (Codec complementar para os programas de edição de vídeo)
		lame (Dependência do DeaDBeeF)
		tuxguitar-fluidsynth (Plugin do módulo de sons FluidSynth para o TuxGuitar)
		fluid-soundfont-gm (Biblioteca de sons para o FluidSynth)
		rawtherapee (Editor de imagens raw)
		openlp (Projetor de imagens para apresentações e igrejas)
		puddletag (Editor de etiquetas para arquivos de áudio)

	Instalado o ambiente gráfico alternativo XFCE com recursos mínimos:
		xfce4-session (Sessão do ambiente gráfico XFCE)
		xfce4-panel (Painel do ambiente gráfico XFCE)
		xfce4-whiskermenu-plugin (Menu para o painel do ambiente gráfico XFCE)
		xfce4-indicator-plugin (Miniaplicativo indicador para o painel do ambiente gráfico XFCE)
		volti (Gerenciador de volume para o painel do ambiente gráfico XFCE)
		xfwm4 (Gerenciador de janelas do ambiente gráfico XFCE)
		compton (Compositor de janelas para o ambiente gráfico XFCE)
		xscreensaver (Protetor de tela para o ambiente gráfico XFCE)

	Aplicativos removidos ou substituídos:
		xcursor-themes (Tema de cursores)
		nautilus (Gerenciador de arquivos)
		transmission-common (Cliente torrent)
		totem-common (Tocador de mídia)
		gnome-mahjongg (Jogo Mahjongg)
		gnome-sudoku (Jogo Sudoku)
		gnome-mines (Jogo de campo minado)
		aisleriot (Jogo de cartas)
		empathy (Comunicador instantâneo)
		gnome-screenshot (Captura de tela)
		usb-creator-common (Criador de pendrives de instalação para sistemas Linux)
		remmina-common (Acesso remoto)
		plymouth-theme-ubuntu-logo (Tema da tela de inicialização do sistema, modo gráfico)
		plymouth-theme-ubuntu-text (Tema da tela de inicialização do sistema, modo texto)
		plymouth-label (Controle de rótulo da tela de inicialização do sistema)
		software-center-aptdaemon-plugins (Central de programas do Ubuntu)
		rhythmbox-data rhythmbox (Player de músicas)

	Pacotes adicionais removidos:
		xfdesktop4-data (Gerenciador da área de trabalho do ambiente gráfico XFCE)
		xfce4-volumed (Gerenciador das teclados de volume do ambiente gráfico XFCE)
		meterbridge (Medidor de sinal para o servidor de áudio Jack)
		qsynth (Interface gráfica para o módulo de sons FluidSynth)
		sni-qt:i386 (Gerenciador do miniaplicativo indicador para aplicativos Qt 32 bits)
		steadyflow (Gerenciador de downloads)

	Dependências extras removidas.

	Pacotes órfãos removidos.

	Instalada a dependência libgcrypt11 #SPOTIFY TMP_FIX

	Aplicativos de terceiros instalados sem o uso do APT:
		Hamachi (Gerenciamento de redes VPN)
		Syncthing-GTK (Interface gráfica para o sincronizador de arquivos em rede local Syncthing)
		Copy (Sincronização de arquivos na núvem)
		MEOCloud (Sincronização de arquivos na núvem)
		Messenger (Comunicador instantâneo para o Facebook)
		Quassel (Comunicador instantâneo para o IRC)
		CGRU Afanasy (Gerenciador de fazendas de renderização de vídeo)
		Cinelerra (Editor de vídeos)
		Natron (Compositor de vídeos)
		Nuke (Compositor de vídeos)
		MPV + Youtube-DL (Player de mídia e baixador de arquivos para o plugin do Firefox)
			(https://addons.mozilla.org/en-US/firefox/addon/watch-with-mpv/)
		DeaDBeeF (Player de música e conversor de arquivos de áudio com suporte à uma grande quantidade formatos)
		REAPER + MIME + REAPER SWS + REAPER codecs # FFMPEG # LAME (Estação de trabalho de áudio com diversos complementos)
		VST plugins (Plugins para o REAPER)
		#Optional VST plugins + Drum Core 3 Free + SampleTank 3 Custom Shop + UVI Workstation (Plugins opcionais para o REAPER)
		LICEcap (Gravador de tela em formato de imagem)
		TagSpaces (Editor de anotações)
		Popcorn Time (Biblioteca de filmes, séries e animes para assistir através do protocolo torrent)
		Steam (Loja de jogos)
		App Grid (Central de programas)
		Sublime Text (Editor de códigos)

	Configurações específicas:
		Cadence/Jack/Qasmixer/Volti
		WINEASIO registrado
		Nemo como padrão
		WINE como padrão
		Configurações do player Parole
		Configurações do GIMP
		Configurações para o TuxGuitar, com suporte ao FluidSynth
		Tema Krita-Dark no KDEnLive
		Tema Holo no OpenShot
		Notificações pra comandos longos no terminal
		Correção para o configurador do Samba(system-config-samba) #VIVID&WILY TMP_FIX
		Sessões customizadas para Unity e XFCE
		Configurações específicas para o XFCE
		APT configurado para não sobreescrever configurações de pacotes
		O compartilhamento de arquivos na rede é configurado para iniciar automaticamente com configurações padrão(gshare)
		O Acesso remoto do sistema é configurado para iniciar automaticamente com configurações padrão
		Configurações específicas do Unity:
			Teclas de atalho customizadas:
				Aumentar o volume
				Abaixar o volume
				Capturar a tela inteira
				Selecionar uma área para capturar
				Desativar demais teclas relacionadas às ações customizadas
			Configurações do Compiz:
				Ubuntu Unity Plugin > General > Panel Opacity = 0,2000
				Ubuntu Unity Plugin > General > Panel Opacity for Maximized Windows Toogle = true
				Ubuntu Unity Plugin > General > Background Color = #000000+Opacidade = 80
				Ubuntu Unity Plugin > Launcher > Launcher Opacity = 0,2000
				Ubuntu Unity Plugin > Launcher > Minimize Single Window Applications (Unsupported) = true
				Mover Janela > Iniciar Movimento de Janelas = <Super>Button1
				Colocar Janelas > Geral > Modo de Multi Saída = Usar dispositivo de saída com o cursor
			Favoritos do Unity redefinidos para os aplicativos padrão do AviX
			Configurações da ferramenta de ajustes do Unity:
				Unity > Pesquisar > Buscar fontes online = false
				Unity > Pesquisar > Mostrar "mais sugestões" = false
				Unity > Barra superior > Data = true
				Unity > Barra superior > Dia da semana = true
				Unity > Barra superior > Volume = false
				Sistema > Rolagem > Barras de rolagem = Antigo
				Indicator de layout do teclado oculto
				Indicador de bateria configurado para exibir somente quando está carregando
				Tema GTK = Vertex
				Tema de ícones = Numix-Cirle
				Menu configurado para exibir ícones
				Botões configurados para exibir ícones
				Fonte do sistema = Proxima Nova 10
				Fonte do terminal = Anonymous Pro 12

	Identidade visual do AviX:
		Exibição do nome "AviX 2.0" no GRUB
		Tema da tela de inicialização
		Plano de fundo da área de trabalho
		Ícone do lançador de aplicativos do Unity
		Exibição do nome "Área de trabalho" no painel do Unity ao fechar todas as janelas
		Logotipo do AviX nos detalhes do sistema
		Remoção do logotipo do Ubuntu na tela de login
		Tema do Microsoft Office no LibreOffice
		Tema Numix para o Pidgin, para combinar com o tema de ícones do sistema
		Tema Vertex escuro no Firefox, para combinar com o tema do sistema
		Tema escuro para aplicativos específicos:
			Deluge Torrent
			GIMP
			Inkscape
			OpenLP
			RawTherapee
			KDEnLive
			OpenShot
			Shutter
			Quassel
		Correção de informações em lançadores de aplicativo:
			Nemo
			pyRenamer
			XDiagnose
			WebBrowser-App
			Calligra
			TuxGuitar
		Pastas padrão criadas pelo script:
			Dropbox
			MEOCloud
			Copy
			Plugins VST (Wine)
			VirtualBox
			Projetos
			Steam
			Sync (Syncthing)
			Shared Files (GShare)
			SparkleShare (GitHub)
		Criados atalhos no gerenciador de arquivos para as pastas padrão
	
	Configurações específicas para desempenho de vídeo:
			O gerenciador de energia da NVIDIA é configurado para o desempenho máximo
			O Unity é configurado para o modo de gráficos reduzidos
