From: =?iso-8859-1?Q?S=F6nke_Ruempler?= <ruempler@topconcepts.com>
Subject: CMD649 hardware raid support
Date: Fri, 12 Sep 2003 09:52:05 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00bb01c37902$c299ca20$9700a8c0@eagle>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.city-map.de ([62.116.172.149]:16567 "EHLO mail.city-map.de")
	by vger.kernel.org with ESMTP id S261217AbTILHwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Sep 2003 03:52:06 -0400
Received: from mail.topconcepts.net
	by mail.city-map.de (62.116.172.149:25) with [XMail 1.16 (Linux/Ix86) ESMTP Server]
	id <S36E441> for <linux-ide@vger.kernel.org> from <ruempler@topconcepts.com>;
	Fri, 12 Sep 2003 09:52:03 +0200
Received: from eagle
	by blah.topconcepts.net with [XMail 1.16 (Linux/Ix86) ESMTP Server]
	id <S3C4D3> for <linux-ide@vger.kernel.org> from <ruempler@topconcepts.com>;
	Fri, 12 Sep 2003 10:02:52 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hi ide-devels,

i have a cmd649 hardware raid controller with 2 maxtor hdd's. in the
controller bios setup i bound them to a raid-1 array.

now linux finds the card

CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
CMD649: ROM enabled at 0xeff00000
    ide2: BM-DMA at 0xd600-0xd607, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd608-0xd60f, BIOS settings: hdg:pio, hdh:pio

hde: attached ide-disk driver.
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63
hdf: attached ide-disk driver.
hdf: host protected area => 1
hdf: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63

and as everybody can see linux IGNORES the raid. imho the hardware raid
array should be transparent to the os and show 1 device to it. linux seems
to simply ignore this.

here the lspci:

00:0c.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
        Subsystem: CMD Technology Inc: Unknown device 3649
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at de00 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 2: I/O ports at da00 [size=8]
        Region 3: I/O ports at d800 [size=4]
        Region 4: I/O ports at d600 [size=16]
        Expansion ROM at eff00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=3 PME-


So what can i do?

--
Soenke

