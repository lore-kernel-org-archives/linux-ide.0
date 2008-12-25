From: Luis Sousa <ls.luis_sousa@yahoo.com.br>
Subject: Re: sata io freeze, 2.6.18 and also 2.6.24 [the real culprit]
Date: Thu, 25 Dec 2008 01:19:02 -0800 (PST)
Message-ID: <591505.79008.qm@web46008.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from n70.bullet.mail.sp1.yahoo.com ([98.136.44.38]:26399 "HELO
	n70.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751709AbYLYJTF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Dec 2008 04:19:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: devzero@web.de
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Dear Linux developers,

I carried this thread on in April 2008 because my computer was crashing=
 every other day. I tried and tried and thought I had reached a solutio=
n many a time, but eventually they all proved illusive. Eventually the =
box kept crashing every other day, applications often dumped core and t=
he only SysRq combination to work was the B one.

But then my motherboard burned out. So I went and bought another one. A=
nd magically all my problems disappeared. Interestingly enough, the tem=
perature seems to have gone down at least 15=B0C.

I'm not sure if this can still be a kernel issue, but it definitely see=
ms not to me. I had installed FreeBSD on the system back then and it wo=
uld crash also. Anyway, my faith in Linux has risen up once again. This=
 system seems rock solid now, it's been a while.

I'd like to say thanks to all, and I'm glad to have such a great stable=
 system once again. Thank you for developing this incredible system, it=
 is definitely a superior system for me, and "superior" in this case is=
 a self-sufficient term.

Best regards,
--
Luis Sousa

--- Em seg, 14/4/08, Luis Sousa <ls.luis_sousa@yahoo.com.br> escreveu:
De: Luis Sousa <ls.luis_sousa@yahoo.com.br>
Assunto: Re: sata io freeze, 2.6.18 and also 2.6.24 [the real culprit]
Para: devzero@web.de
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kerne=
l.org
Data: Segunda-feira, 14 de Abril de 2008, 22:24

--- devzero@web.de escreveu:

> so - you told, you have your disk attached to this controller:
>=20
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA R=
AID
Controller (rev
> 80)
> 	Subsystem: Micro-Star International Co., Ltd. Unknown device 0430
> 	Flags: bus master, medium devsel, latency 32, IRQ 16
> 	I/O ports at ec00 [size=3D8]
> 	I/O ports at e800 [size=3D4]
> 	I/O ports at e400 [size=3D8]
> 	I/O ports at e000 [size=3D4]
> 	I/O ports at dc00 [size=3D16]
> 	I/O ports at d800 [size=3D256]
> 	Capabilities: <access denied>
>=20
> and use sata_via module - and your system works stable with nosmp, bu=
t
freezes very soon
> on heavy i/o with smp. disabling dma makes no difference.
>=20
> correct ?

Correct.=20

But I'm not sure it's an exclusive i/o thing. I've had the box
crash in
situations where I don't think heavy i/o is involved.. for instance, it
crashed two times just as I closed the iceape browser.
=20
> then i assume this could be an smp issue, probably a bug in sata_via =
and
may need further
> investigation.
>=20
> there seem no noticeable changes in that driver since 2.6.24 - but ma=
ybe
it`s worth
> trying 2.6.25-rc9 to see if it behaves different?

I'm actually running 2.6.25-rc7-git6 now.
(so I really don't think that would make much of a difference)

> absolutely nothing in dmesg on freeze ?

Absolutely nothing. Never.
=20
> maybe you could try catching some message with attaching serial conso=
le?

Hmm, I have no serial consoles here, and my spare box is dead.=20

Unless I can attach netconsole to a windows box.

I can probably crash it in console mode, without Xorg. Then I hope some=
thing
might show up in another vt at least.

> how reliably can you crash that box with lots of i/o ? just random cr=
ashes
or after a
> certain amount of data written/read ?

There is definitely a random element in it. But I can reliably crash it=
=2E
Just trigger some CPU and i/o bound processes. I've crashed it with
operations
which would only read from the disk, for instance unpacking to /dev/nul=
l.
Sometimes it takes longer, though.

> could you try if just reading from the raw blockdevice makes a differ=
nce ?
(dd
> if=3D/dev/sda of=3D/dev/zero)

Yes, I can try that. But please bear with me as I won't be working full
time
in this. I hope we can get to the bottom of this, but it might not be a=
s quick
as we'd like.

Thank you very much for the help.

I'll write back asap.

Best regards,
--
Luis Sousa

> > -----Urspr=FCngliche Nachricht-----
> > Von: "Luis Sousa" <ls.luis_sousa@yahoo.com.br>
> > Gesendet: 14.04.08 12:14:26
> > An: devzero@web.de
> > CC: linux-kernel@vger.kernel.org
> > Betreff: Re: sata io freeze, 2.6.18 and also 2.6.24 [the real
culprit]
>=20
>=20
> >=20
> > Hello,
> >=20
> > I did as planned, and I dare to say now, with
> > relative certainty, that the reason I have had all
> > these instabilities, including application crashes,
> > sneaky corrupt backups, and the dreaded freezes
> > every other day was SMP and HyperThreading not working
> > properly. Booting with nosmp gives me a stable system.
> > Booting only with the sata-related arguments had
> > the system freeze overnight.
> >=20
> > Sincerely,
> > --
> > Luis Sousa
> >=20
> > --- devzero@web.de escreveu:
> >=20
> > > hi luis,=20
> > >=20
> > > glad that it worked - but let us better call this a possible
workaround, not a
> solution.
> > >=20
> > > mind that you loose lots of performance with this, because all
i/o is handled by the
> cpu
> > > now.
> > >=20
> > > > If everything goes well, I'll reduce the command line
> > > > in order to narrow the problem further down.
> > >=20
> > > yes, please!
> > >=20
> > > regards
> > > roland
> > >=20
> > >=20
> > > > -----Urspr=FCngliche Nachricht-----
> > > > Von: "Luis Sousa"
<ls.luis_sousa@yahoo.com.br>
> > > > Gesendet: 12.04.08 17:34:39
> > > > An: devzero@web.de
> > > > CC: linux-kernel@vger.kernel.org
> > > > Betreff: Re: sata io freeze, 2.6.18 and also 2.6.24
[POSSIBLE SOLUTION]
> > >=20
> > >=20
> > > >=20
> > > > Hello all,
> > > >=20
> > > > Thanks to valuable help from roland, I was able to
> > > > boot with the following options:
> > > >=20
> > > > ``nosmp ide=3Dnodma libata.dma=3D0''
> > > >=20
> > > > after what I ran an agressive stability test for a
> > > > while, with no problem whatsoever. Maybe it's too
> > > > soon to say, but I have a good feeling this time. It
> > > > seems roland figured it out.
> > > >=20
> > > > If everything goes well, I'll reduce the command line
> > > > in order to narrow the problem further down.
> > > >=20
> > > > (and indeed, this is a hyper-threading single core CPU)
> > > >=20
> > > > Sincerely,
> > > > --
> > > > Luis Sousa
> > > >=20
> > > > --- devzero@web.de escreveu:
> > > >=20
> > > > > did you try UP-kernel or tried booting with
"nosmp" and does that make any
> difference
> > > ?
> > > > >=20
> > > > > >This is a 2-processor CPU:
> > > > > ># cat /proc/cpuinfo=20
> > > > > >processor       : 0
> > > > > >vendor_id       : GenuineIntel
> > > > > >cpu family      : 15
> > > > > >model           : 4
> > > > > >model name      : Intel(R) Pentium(R) 4 CPU
3.00GHz
> > > > >=20
> > > > > most likely this just "appears" as 2-way
processor , but i=B4m quite sure this is
> just
> > > a
> > > > > single-core CPU, but with HyperThreading enabled.
> > > > >=20
> > > > >=20
> > > > > regards
> > > > > roland
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > List:       linux-kernel
> > > > > Subject:    sata io freeze, 2.6.18 and also 2.6.24
> > > > > From:       Luis Sousa <ls.luis_sousa () yahoo !
com ! br>
> > > > > Date:       2008-03-28 22:24:48
> > > > > Message-ID: 739784.81690.qm () web46009 ! mail ! sp1 !
yahoo ! com
> > > > > [Download message RAW]
> > > > >=20
> > > > > Hello,
> > > > >=20
> > > > > I've been having consistent hard system freezes
for a
> > > > > long time, every 2 days or so, and finally decided to
> > > > > move to the most recent stable kernel. Unfortunatelly
> > > > > that didn't fix it. The freezes seem to be
io-related;
> > > > > they started since I moved my drive to sata. They seem
> > > > > to happen mostly when there's an io-intensive
operation,
> > > > > like extracting a big archive; a reboot is needed.
> > > > >=20
> > > > > Nothing ever shows up in the logs.
> > > > >=20
> > > > > I'm using the following drive:
> > > > >=20
> > > > > ATA device, with non-removable media
> > > > >         Model Number:       MAXTOR STM3160215AS      =20
            =20
> > > > >         Serial Number:      6RA2TMJ4
> > > > >         Firmware Revision:  3.AAD  =20
> > > > >=20
> > > > > Linux localhost 2.6.24.4 #4 SMP Fri Mar 28 14:51:50
BRT 2008 i686 GNU/Linux
> > > > >=20
> > > > > This is a 2-processor CPU:
> > > > >=20
> > > > > # cat /proc/cpuinfo=20
> > > > > processor       : 0
> > > > > vendor_id       : GenuineIntel
> > > > > cpu family      : 15
> > > > > model           : 4
> > > > > model name      : Intel(R) Pentium(R) 4 CPU 3.00GHz
> > > > > stepping        : 9
> > > > > cpu MHz         : 3013.697
> > > > > cache size      : 1024 KB
> > > > >=20
> > > > > (same goes for processor : 1)
> > > > >=20
> > > > > Sincerely,
> > > > > --
> > > > > Luis Sousa


      Veja quais s=E3o os assuntos do momento no Yahoo! +Buscados
http://br.maisbuscados.yahoo.com

