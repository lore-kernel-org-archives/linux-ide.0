From: Andre Duffeck <andre.duffeck@arcor.de>
Subject: Poor hd-performance (ALI M15x3-Chipset)
Date: Thu, 25 Nov 2004 16:56:22 +0100
Message-ID: <1101398182.13703.11.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:31421 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262479AbUK0AzM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2004 19:55:12 -0500
Received: from localhost (dsl-213-023-029-049.arcor-ip.net [213.23.29.49])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 13C29CA6B6
	for <linux-ide@vger.kernel.org>; Thu, 25 Nov 2004 16:57:32 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

hello,

i'm experiencing extremely poor performance of my harddisk. it is a
laptop-disk, but it should be faster, i think.

laptop:/usr/src/linux/linux-2.6.9# hdparm -tT /dev/hda

/dev/hda:
 Timing cached reads:   1248 MB in  2.00 seconds =3D 623.16 MB/sec
 Timing buffered disk reads:   14 MB in 10.85 seconds =3D   1.29 MB/sec

laptop:/home/andre# hdparm /dev/hda

/dev/hda:
 multcount    =3D  0 (off)
 IO_support   =3D  0 (default 16-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 geometry     =3D 16383/255/63, sectors =3D 30005821440, start =3D 0

playing with the settings did not help.

laptop:/usr/src/linux/linux-2.6.9# hdparm -X66 /dev/hda
		/dev/hda:
		 setting xfermode to 66 (UltraDMA mode2)
laptop:/home/andre# hdparm -c1 /dev/hda
		/dev/hda:
		 setting 32-bit IO_support flag to 1
		 IO_support   =3D  1 (32-bit)

laptop:/home/andre# hdparm -t /dev/hda
		/dev/hda:
		 Timing buffered disk reads:   14 MB in 10.75 seconds =3D   1.30 MB/s=
ec

here some more information:
dmesg:
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: PCI interrupt 0000:00:10.0[A]: no GSI
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2480-0x2487, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2488-0x248f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: FUJITSU MHR2030AT, ATA DISK drive

lspci:
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)

Can anybody guess what's wrong here?

thank you,

Andr=E9


