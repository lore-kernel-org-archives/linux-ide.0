From: Jure =?UTF-8?Q?Pe=C3=A8ar?= <pegasus@nerv.eu.org>
Subject: Re: sil3112 on alpha
Date: Mon, 23 Aug 2004 22:33:12 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040823223312.0e7a4922.pegasus@nerv.eu.org>
References: <20040823203106.1ffded22.pegasus@nerv.eu.org>
	<412A408B.5030107@pobox.com>
	<20040823212536.7c4bc225.pegasus@nerv.eu.org>
	<412A5244.3060205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from feather2.animeslovenija.org ([193.77.122.70]:63453 "EHLO
	mail.animeslovenija.org") by vger.kernel.org with ESMTP
	id S266786AbUHWUdR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2004 16:33:17 -0400
Received: from localhost (disko [192.168.200.4])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id 6E9F39BD4
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2004 22:33:20 +0200 (CEST)
Received: from mail.animeslovenija.org ([192.168.200.3])
 by localhost (disko [192.168.200.4]) (amavisd-new, port 10024) with LMTP
 id 22072-01-4 for <linux-ide@vger.kernel.org>;
 Mon, 23 Aug 2004 22:33:12 +0200 (CEST)
Received: from moonlight.pecar.org (jarse [193.95.219.68])
	by mail.animeslovenija.org (8.7.6/8.7.6) with ESMTP id 98C4D9BD1
	for <linux-ide@vger.kernel.org>; Mon, 23 Aug 2004 22:33:16 +0200 (CEST)
In-Reply-To: <412A5244.3060205@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Mon, 23 Aug 2004 16:23:32 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

=20
> Your message said sil3112, which is SATA-only.
>=20
> I guess you have a CMD680...

Sorry, i forgot to fix the subject too :)
Yes, they are cmd680 cards, 'medley' or what are they called ...=20

0000:01:02.0 RAID bus controller: Silicon Image, Inc. (formerly CMD
Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Winic W-6=
80
(Silicon Image 680 based)

used with CONFIG_BLK_DEV_SIIMAGE=3Dy

and recognized as:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
SiI680: IDE controller at PCI slot 0000:00:0d.0
SiI680: chipset revision 2
SiI680: BASE CLOCK =3D=3D 133
SiI680: 100% native mode on irq 22
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: IC35L060AVVA07-0, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0xfffffc86023a1080-0xfffffc86023a1087,0xfffffc86023a108a on irq=
 22
hdc: IC35L060AVVA07-0, ATA DISK drive
ide1 at 0xfffffc86023a10c0-0xfffffc86023a10c7,0xfffffc86023a10ca on irq=
 22
SiI680: IDE controller at PCI slot 0000:01:02.0
SiI680: chipset revision 2
SiI680: BASE CLOCK =3D=3D 133
SiI680: 100% native mode on irq 26
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: IC35L060AVVA07-0, ATA DISK drive
ide2 at 0xfffffc86022f2080-0xfffffc86022f2087,0xfffffc86022f208a on irq=
 26
hdg: IC35L060AVVA07-0, ATA DISK drive
ide3 at 0xfffffc86022f20c0-0xfffffc86022f20c7,0xfffffc86022f20ca on irq=
 26


--=20

Jure Pe=E8ar
