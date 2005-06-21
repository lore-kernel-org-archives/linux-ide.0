From: Yuri Kirsanov <flash@rccb.ru>
Subject: Re[6]: TX4000 RAID and sata_promise
Date: Tue, 21 Jun 2005 22:24:24 +0400
Message-ID: <253506078.20050621222424@rccb.ru>
References: <01f501c5a223$9faf5470$6f0aa8c0@rgkb.local>
 <4301E5C5.2030203@dtbb.net>  <1124199054.5550.71.camel@localhost.localdomain>
 <015701c5a267$594284f0$6f0aa8c0@rgkb.local>
 <1124200207.5550.74.camel@localhost.localdomain>
 <016a01c5a26a$1745ca50$6f0aa8c0@rgkb.local>
 <1124200516.5550.77.camel@localhost.localdomain>
 <017501c5a26a$bb31bfc0$6f0aa8c0@rgkb.local>
 <1124202300.19419.0.camel@localhost.localdomain>
 <1721975015.20050621203841@rccb.ru>
 <1124211467.19419.24.camel@localhost.localdomain>
 <71290359.20050621214728@rccb.ru>
 <1124215786.29001.2.camel@localhost.localdomain>
Reply-To: Yuri Kirsanov <flash@rccb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [213.85.106.100] ([213.85.106.100]:46555 "EHLO rccb.ru")
	by vger.kernel.org with ESMTP id S1030268AbVHPSXk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2005 14:23:40 -0400
In-Reply-To: <1124215786.29001.2.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

ES> Hmm, then I guess it would be very interesting to know WHY it doesn't
ES> load at boot time! What are the symptoms?

ES> It seems to strange to me that sata reports PATA devices... What kind of
ES> harddisks do you connected (brand, type, pata/sata?)

I don't know why it doesn't load autoload, maybe I need to insert
something into /etc/modprobe.conf?

Here's my 'lspci' and 'lspcidrake' (lspcidrake is a Mandrake Linux
tool):

[root@mandr ~]# lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller] (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 02)
00:1f.3 SMBus: Intel Corporation 82801BA/BAM SMBus (rev 02)
00:1f.4 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #2) (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA/BAM AC'97 Audio (rev 02)
01:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
01:09.0 RAID bus controller: Promise Technology, Inc. PDC20619 (FastTrak TX4000) (rev 02)


[root@mandr ~]# lspcidrake
intel-agp       : Intel Corp.|82815 815 Chipset Host Bridge and Memory Controller Hub [BRIDGE_HOST]
Card:Intel 815  : Intel Corp.|82815 CGC [Chipset Graphics Controller] [DISPLAY_VGA]
hw_random       : Intel Corp.|82820 815e (Camino 2) Chipset PCI [BRIDGE_PCI]
i810-tco        : Intel Corp.|82820 815e (Camino 2) Chipset ISA Bridge (ICH2) [BRIDGE_ISA]
piix            : Intel Corp.|82820 815e (Camino 2) Chipset IDE U100 [STORAGE_IDE]
usb-uhci        : Intel Corp.|82820 815e (Camino 2) Chipset USB (Hub A) [SERIAL_USB]
i2c-i801        : Intel Corp.|82820 815e (Camino 2) Chipset SMBus [SERIAL_SMBUS]
usb-uhci        : Intel Corp.|82820 815e (Camino 2) Chipset USB (Hub B) [SERIAL_USB]
i810_audio      : Intel Corp.|ICH2 810 Chipset AC'97 Audio Controller [MULTIMEDIA_AUDIO]
3c59x           : 3Com Corp.|3c905C-TX [Fast Etherlink] [NETWORK_ETHERNET]
sata_promise    : Promise Technology|FastTrak TX4000 Controller [STORAGE_RAID]
hub             : Linux 2.6.12.4-10flh uhci_hcd|Intel Corporation 82801BA/BAM USB (Hub #2) [Hub|Unused]
hub             : Linux 2.6.12.4-10flh uhci_hcd|Intel Corporation 82801BA/BAM USB (Hub #1) [Hub|Unused]

