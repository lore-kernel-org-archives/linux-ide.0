From: devzero@web.de
Subject: Re: sata io freeze, 2.6.18 and also 2.6.24 [the real culprit]
Date: Tue, 15 Apr 2008 00:03:39 +0200
Message-ID: <238986828@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate04.web.de ([217.72.192.242]:37016 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbYDNWDl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 18:03:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Luis Sousa <ls.luis_sousa@yahoo.com.br>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

so - you told, you have your disk attached to this controller:

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAI=
D Controller (rev 80)
	Subsystem: Micro-Star International Co., Ltd. Unknown device 0430
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at ec00 [size=3D8]
	I/O ports at e800 [size=3D4]
	I/O ports at e400 [size=3D8]
	I/O ports at e000 [size=3D4]
	I/O ports at dc00 [size=3D16]
	I/O ports at d800 [size=3D256]
	Capabilities: <access denied>

and use sata_via module - and your system works stable with nosmp, but =
freezes very soon on heavy i/o with smp. disabling dma makes no differe=
nce.

correct ?

then i assume this could be an smp issue, probably a bug in sata_via an=
d may need further investigation.

there seem no noticeable changes in that driver since 2.6.24 - but mayb=
e it`s worth trying 2.6.25-rc9 to see if it behaves different?
absolutely nothing in dmesg on freeze ?=20
maybe you could try catching some message with attaching serial console=
?
how reliably can you crash that box with lots of i/o ? just random cras=
hes or after a certain amount of data written/read ?
could you try if just reading from the raw blockdevice makes a differnc=
e ? (dd if=3D/dev/sda of=3D/dev/zero)




> -----Urspr=FCngliche Nachricht-----
> Von: "Luis Sousa" <ls.luis_sousa@yahoo.com.br>
> Gesendet: 14.04.08 12:14:26
> An: devzero@web.de
> CC: linux-kernel@vger.kernel.org
> Betreff: Re: sata io freeze, 2.6.18 and also 2.6.24 [the real culprit=
]


>=20
> Hello,
>=20
> I did as planned, and I dare to say now, with
> relative certainty, that the reason I have had all
> these instabilities, including application crashes,
> sneaky corrupt backups, and the dreaded freezes
> every other day was SMP and HyperThreading not working
> properly. Booting with nosmp gives me a stable system.
> Booting only with the sata-related arguments had
> the system freeze overnight.
>=20
> Sincerely,
> --
> Luis Sousa
>=20
> --- devzero@web.de escreveu:
>=20
> > hi luis,=20
> >=20
> > glad that it worked - but let us better call this a possible workar=
ound, not a solution.
> >=20
> > mind that you loose lots of performance with this, because all i/o =
is handled by the cpu
> > now.
> >=20
> > > If everything goes well, I'll reduce the command line
> > > in order to narrow the problem further down.
> >=20
> > yes, please!
> >=20
> > regards
> > roland
> >=20
> >=20
> > > -----Urspr=FCngliche Nachricht-----
> > > Von: "Luis Sousa" <ls.luis_sousa@yahoo.com.br>
> > > Gesendet: 12.04.08 17:34:39
> > > An: devzero@web.de
> > > CC: linux-kernel@vger.kernel.org
> > > Betreff: Re: sata io freeze, 2.6.18 and also 2.6.24 [POSSIBLE SOL=
UTION]
> >=20
> >=20
> > >=20
> > > Hello all,
> > >=20
> > > Thanks to valuable help from roland, I was able to
> > > boot with the following options:
> > >=20
> > > ``nosmp ide=3Dnodma libata.dma=3D0''
> > >=20
> > > after what I ran an agressive stability test for a
> > > while, with no problem whatsoever. Maybe it's too
> > > soon to say, but I have a good feeling this time. It
> > > seems roland figured it out.
> > >=20
> > > If everything goes well, I'll reduce the command line
> > > in order to narrow the problem further down.
> > >=20
> > > (and indeed, this is a hyper-threading single core CPU)
> > >=20
> > > Sincerely,
> > > --
> > > Luis Sousa
> > >=20
> > > --- devzero@web.de escreveu:
> > >=20
> > > > did you try UP-kernel or tried booting with "nosmp" and does th=
at make any difference
> > ?
> > > >=20
> > > > >This is a 2-processor CPU:
> > > > ># cat /proc/cpuinfo=20
> > > > >processor       : 0
> > > > >vendor_id       : GenuineIntel
> > > > >cpu family      : 15
> > > > >model           : 4
> > > > >model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
> > > >=20
> > > > most likely this just "appears" as 2-way processor , but i=B4m =
quite sure this is just
> > a
> > > > single-core CPU, but with HyperThreading enabled.
> > > >=20
> > > >=20
> > > > regards
> > > > roland
> > > >=20
> > > >=20
> > > >=20
> > > > List:       linux-kernel
> > > > Subject:    sata io freeze, 2.6.18 and also 2.6.24
> > > > From:       Luis Sousa <ls.luis_sousa () yahoo ! com ! br>
> > > > Date:       2008-03-28 22:24:48
> > > > Message-ID: 739784.81690.qm () web46009 ! mail ! sp1 ! yahoo ! =
com
> > > > [Download message RAW]
> > > >=20
> > > > Hello,
> > > >=20
> > > > I've been having consistent hard system freezes for a
> > > > long time, every 2 days or so, and finally decided to
> > > > move to the most recent stable kernel. Unfortunatelly
> > > > that didn't fix it. The freezes seem to be io-related;
> > > > they started since I moved my drive to sata. They seem
> > > > to happen mostly when there's an io-intensive operation,
> > > > like extracting a big archive; a reboot is needed.
> > > >=20
> > > > Nothing ever shows up in the logs.
> > > >=20
> > > > I'm using the following drive:
> > > >=20
> > > > ATA device, with non-removable media
> > > >         Model Number:       MAXTOR STM3160215AS                =
    =20
> > > >         Serial Number:      6RA2TMJ4
> > > >         Firmware Revision:  3.AAD  =20
> > > >=20
> > > > Linux localhost 2.6.24.4 #4 SMP Fri Mar 28 14:51:50 BRT 2008 i6=
86 GNU/Linux
> > > >=20
> > > > This is a 2-processor CPU:
> > > >=20
> > > > # cat /proc/cpuinfo=20
> > > > processor       : 0
> > > > vendor_id       : GenuineIntel
> > > > cpu family      : 15
> > > > model           : 4
> > > > model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
> > > > stepping        : 9
> > > > cpu MHz         : 3013.697
> > > > cache size      : 1024 KB
> > > >=20
> > > > (same goes for processor : 1)
> > > >=20
> > > > Sincerely,
> > > > --
> > > > Luis Sousa
>=20
>=20
>=20
>       Abra sua conta no Yahoo! Mail, o =FAnico sem limite de espa=E7o=
 para armazenamento!
> http://br.mail.yahoo.com/
>=20
>=20


_______________________________________________________________________=
__
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten=
!=20
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=3D021114

