From: infernix <infernix@infernix.net>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 13 Feb 2010 00:30:58 +0100
Message-ID: <4B75E4B2.3070105@infernix.net>
References: <4B591D61.8030003@infernix.net>	<4B593128.1040104@gmail.com>	<4B59A0CD.4000801@infernix.net>	<4B5A4F7A.4040709@gmail.com>	<4B5A5F09.1070300@infernix.net>	<20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>	<4B5AF4DF.4020100@infernix.net> <20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dx.infernix.net ([83.96.151.193]:44111 "EHLO dx.infernix.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab0BLXan (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Feb 2010 18:30:43 -0500
Received: from [192.168.0.3] (believe.infernix.lan [192.168.0.3])
	by dx.infernix.net (8.14.3/8.14.3/Debian-5) with ESMTP id o1CNUfOa000683
	for <linux-ide@vger.kernel.org>; Sat, 13 Feb 2010 00:30:42 +0100
In-Reply-To: <20100123133831.7f24ae95@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi again,

It's been a while because I got a bad set of hard disks to start testin=
g=20
with, but I'm all set now that I've got new ones. Both the PATA port=20
with the IDE DOM as well as all the SATA ports are recognised and=20
working now.

PATA_LEGACY Depends on: ATA [=3Dy] && ATA_SFF [=3Dy] && ISA [=3Dn] &&=20
EXPERIMENTAL [=3Dy]                                            =E2=94=82

To make it work, PATA_LEGACY needs to have the ISA dependancy removed=20
(at least on x86_64). Not sure if that's been committed by anyone yet.


So, it boots up fine, but doesn't use DMA (it's ata7+8):

[    1.399227] ata1: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fd00 irq 26
[    1.406607] ata2: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fd80 irq 26
[    1.413981] ata3: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fe00 irq 26
[    1.421355] ata4: SATA max UDMA/133 abar m1024@0xffa3fc00 port=20
0xffa3fe80 irq 26
[    1.442719] ata5: SATA max UDMA/100 host m128@0xff8ffc00 port=20
0xff8f8000 irq 18
[    1.450014] ata6: SATA max UDMA/100 host m128@0xff8ffc00 port=20
0xff8fa000 irq 18
[    1.460718] ata7: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[    1.628360] ata7.00: CFA: TRANSCEND, 20071207, max UDMA/66
[    1.633832] ata7.00: 7831152 sectors, multi 0: LBA
[    1.638708] ata7.00: configured for PIO
[    5.671978] ata8: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15

Here's the PATA port performance with the BIOS set to Compatible (ATA_P=
IIX):

Timing cached reads:   1750 MB in  2.00 seconds =3D 875.19 MB/sec
Timing buffered disk reads:   80 MB in  3.01 seconds =3D  26.58 MB/sec

And here's with Enhanced (AHCI + PATA_LEGACY):

Timing cached reads:   770 MB in  2.00 seconds =3D 385.04 MB/sec
Timing buffered disk reads:    6 MB in  3.29 seconds =3D   1.82 MB/sec

On 23/01/10 14:38, Alan Cox wrote:
>> That would make me think it's actually wired to the ICH. Maybe also =
to
>> the LPC bus but I'm not knowledgeable enough to know if thats even p=
ossible.
>
> I'm not sure what occurs if you set up the address decode on the ICH =
for
> the port and then hide it. Seems a strange thing to do but it might b=
e
> the case, and if so we can probably add a Linux quirk based on the DM=
I
> data to unhide it.

How can I try this? And would it yield any performance benefits? It's=20
pretty slow now, and although usable in a NAS setup, it would be nice t=
o=20
try and get more out of it. As far as I can tell, the hardware can do=20
it, judging by the hdparm performance when it's set to compatible mode.

Or is there no more performance to be gained in this mode?

=46ull dmesg, dmidecode and lspci can be found at=20
http://dx.infernix.net/ss4200/

Thanks!
