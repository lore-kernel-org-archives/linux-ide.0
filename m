From: Bernie Innocenti <bernie@codewiz.org>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 14:04:32 -0400
Message-ID: <1254852272.1471.172.camel@giskard>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>
	 <4ACB3741.2030101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.develer.com ([83.149.158.210]:60198 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbZJFSFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 14:05:15 -0400
In-Reply-To: <4ACB3741.2030101@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>

El Tue, 06-10-2009 a las 15:25 +0300, Harri Olin escribi=F3:
> Mark Lord wrote:
> > Bernie Innocenti wrote:
> >> The error in the subject appears in the console immediately follow=
ed bv
> >> a hard freeze of the machine.  The error occurs reproducibly on tw=
o
> >> identical Opteron servers, each one equipped with two identical
> >> controller cards:
> >>
> >> 03:04.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> >> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> >> 03:06.0 SCSI storage controller: Marvell Technology Group Ltd.=20
> >> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
> >>
> >> We can trigger the problem within a few seconds by starting a
> >> reconstruction on a drive hooked to port 4 (counting from 0) of th=
e
> >> second controller.  Oddly, every other drive works reliably and th=
e
> >> faulty drive works if we connect it to, for example, port 4 of the=
 first
> >> controller.
> >>
> >> Tested with Debian kernels 2.6.26-19 and 2.6.30-8.  Let me know if
> >> further details are needed.
> > ..
> >> 0000:03:06.0: PCI ERROR; PCI IRQ cause=3D0x30000040..
> > ..
> >
> >  0x30000040 here means "MRdPerr":
> >    "bad data parity detected during PCI master read".
> >
> > Which means there that a data parity error happened
> > during outgoing data transfer on the PCI-X bus.
> > This could happen due to noise on the bus,
> > dying capacitors, or (?) bad RAM (not sure about the last one).
> >
> I have heard same thing happened with same kind of configuration, usi=
ng=20
> Supermicro H8DME-2 motherboard, Opteron 2378 CPU.
>
>Even the controllers were on same slots.

Close.  Mine is a Supermicro H8DM8-2 with 2x Opteron 2374 HE CPU.


> My initial suspicion was that the motherboard does not drop the PCI-X=
=20
> bus frequency to 100MHz and drives the bus at 133MHz even though ther=
e=20
> are 2 controllers connected. Proposed fix was to move the other=20
> controller to other bus, as the H8DME-2 has four PCI-X slots, 2x100MH=
z=20
> and 2x133MHz, but I haven't yet heard back if it helped.

Thanks for this hint, I'll try this tomorrow,


> Even the kernel was same - latest Debian distribution kernel. Might b=
e=20
> worthwile to try using vanilla kernel.org kernel if possible.

As a matter of fact, yesterday  I tried booting off an Open Solaris
Nexenta CD and I couldn't reproduce the issue, although I couldn't
reproduce the exact same conditions that trigger the bug systematically
on Linux.


> I have at home two 6081 controllers at same bus but at 100MHz and no=20
> problems yet.

Is there a way to find out what the current PCI-X bus frequency is from
Linux?  And from the BIOS?

--=20
   // Bernie Innocenti - http://codewiz.org/
 \X/  Sugar Labs       - http://sugarlabs.org/

