From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: CMD649 hardware raid support
Date: Fri, 12 Sep 2003 14:50:38 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200309121450.38548.bzolnier@elka.pw.edu.pl>
References: <00bb01c37902$c299ca20$9700a8c0@eagle>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30080 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261566AbTILMsX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Sep 2003 08:48:23 -0400
In-Reply-To: <00bb01c37902$c299ca20$9700a8c0@eagle>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-2?q?S=F6nke=20Ruempler?= <ruempler@topconcepts.com>
Cc: linux-ide@vger.kernel.org


CMD649 *doesn't* have hardware RAID.
It is software RAID and kernels 2.4.x have basic support for it.
Alternatively you can use Linux's software RAID.

--bartlomiej

On Friday 12 of September 2003 09:52, S=F6nke Ruempler wrote:
> hi ide-devels,
>
> i have a cmd649 hardware raid controller with 2 maxtor hdd's. in the
> controller bios setup i bound them to a raid-1 array.
>
> now linux finds the card
>
> CMD649: chipset revision 2
> CMD649: not 100% native mode: will probe irqs later
> CMD649: ROM enabled at 0xeff00000
>     ide2: BM-DMA at 0xd600-0xd607, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xd608-0xd60f, BIOS settings: hdg:pio, hdh:pio
>
> hde: attached ide-disk driver.
> hde: host protected area =3D> 1
> hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D158816/16/63
> hdf: attached ide-disk driver.
> hdf: host protected area =3D> 1
> hdf: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=3D158816/16/63
>
> and as everybody can see linux IGNORES the raid. imho the hardware ra=
id
> array should be transparent to the os and show 1 device to it. linux =
seems
> to simply ignore this.
>
> here the lspci:
>
> 00:0c.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
>         Subsystem: CMD Technology Inc: Unknown device 3649
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- P=
arErr-
> Stepping- SERR+ FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TA=
bort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64 (500ns min, 1000ns max)
>         Interrupt: pin A routed to IRQ 10
>         Region 0: I/O ports at de00 [size=3D8]
>         Region 1: I/O ports at dc00 [size=3D4]
>         Region 2: I/O ports at da00 [size=3D8]
>         Region 3: I/O ports at d800 [size=3D4]
>         Region 4: I/O ports at d600 [size=3D16]
>         Expansion ROM at eff00000 [disabled] [size=3D512K]
>         Capabilities: [60] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D3 PME-
>
>
> So what can i do?
>
> --
> Soenke

