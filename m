From: Leopold Palomo-Avellaneda <lepalom@wol.es>
Subject: Re: Sata_via problems in a Vintage2-AE1
Date: Mon, 12 Feb 2007 17:23:16 +0100
Message-ID: <200702121723.17999.lepalom@wol.es>
References: <200702090010.06897.lepalom@wol.es> <45CDDA86.2000607@gmail.com> <200702121011.49818.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from violet.upc.es ([147.83.2.51]:48063 "EHLO violet.upc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964873AbXBLQXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 11:23:39 -0500
In-Reply-To: <200702121011.49818.jdelvare@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

A Dilluns 12 Febrer 2007 10:11, Jean Delvare va escriure:
> Le Samedi 10 F=E9vrier 2007 15:45, Tejun Heo a =E9crit=A0:
> > [cc'ing Alan and Jean, Hi!]
> >
> > Leopold Palomo Avellaneda wrote:
> > > A Divendres 09 Febrer 2007 18:13, Leopold Palomo Avellaneda va es=
criure:
> > >> A Divendres 09 Febrer 2007 10:46, Tejun Heo va escriure:
> > >>> Leopold Palomo Avellaneda wrote:
> > >>>> Dear people,
> > >>>>
> > >>>> I have a barebone Asus Vintage2-AE1 [1]. This box has a mobo A=
sus
> > >>>> A8V-MQ. The board has:
> > >>>> - the Socket 939 for AMD Athlon 64FX/Athlon 64.
> > >>>> - North Bridge: VIA K8M800
> > >>>> - South Bridge: VIA VT8251
> > >>>> - VIA Graphics Integrated
> > >>>> - IDE 2 x UltraDMA 133
> > >>>> - 4 x Serial ATA
> > >>>> ...
> > >>>>
> > >>>> I'm using the bios version 0206. The 0210 doesn't show me the =
vga
> > >>>> card, so I don't have graphics mode. I think that is a buggy b=
ios.
>
> Did you report the problem to Asus? They should fix it. Maybe this ne=
w BIOS
> actually fixes some other problems you have.

no. It's on the todo list. However I'm a bit afraid because I'm not usi=
ng=20
the "official" system so probably they will say that "we do not support=
 ..."

> > >>>> The bios is configured with vt8251 in AHCI mode and bios boot =
up
> > >>>> activated, so the hd is recognized in the beginning. I don't h=
ave
> > >>>> any raid, only one hd. The hd is a Maxtor 6V250F0.
> > >>>>
> > >>>> I'm using a debian etch but the i386 version. The only way tha=
t I
> > >>>> can use the hd is using a 2.6.16 standard kernel with the
> > >>>> modifications explained in this page [2]. Basically you have t=
o use
> > >>>> their ahci.c and sata_via.c. The modifications are small from =
the
> > >>>> original code from Mr Jeff Garzik.
> > >>>>
> > >>>> I have tried to use the 2.6.18 and 2.6.20rc6 and the result is=
 the
> > >>>> same. The kernel boots, but when arrives at the ata3,
> > >>>>
> > >>>> scsi2 : ahci
> > >>>> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >>>> ata3.00: qc timeout (cmd 0xec)
> > >>>> ata3.00: failed to IDENTIFY (I/O error, err_mask=3D0x104)
> > >>>> .... repeated some times ...
> > >>>> scsi3 : ahci
> > >>>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >>>> scsi4 : ahci
> > >>>> ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >>>> scsi5 : ahci
> > >>>> ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >>>> Done.
> > >>>> Begin: Mounting root file system... ...
> > >>>> Begin: Running /scripts/local-top
> > >>>> ide0: I/O resource 0x3F6-0x3F6 not free.
> > >>>> ide0: ports already in use, skipping probe.
> > >>>> ide1: I/O resource 0x376-0x376 not free.
> > >>>> ide1: ports already in use, skipping probe.
> > >>>> Done.
> > >>>> Begin: Waiting for root file system ...
> > >>>
> > >>> It might be VIA IRQ quirk problem.
> > >>>
> > >>> 1. Does giving 'irqpoll' parameter to kernel make any differenc=
e?
> > >>
> > >> yes. Now it boots. However I'm having a lot of messages:
> > >> APIC error on CPU0
> > >> and I begin to have problems with the network card.
> > >>
> > >>> 2. Can you give a shot at 2.6.20?
> > >>
> > >> yes, I'm doing it now.
> > >>
> > >> Thank's a lot. But, why with irqpoll works and without no?
> > >
> > > well, I summarize.
> > >
> > > With the default options of the kernel I cannot boot in this devi=
ce
> > > with any kernel. Only with 2.6.20 and the irqpoll or the 2.6.16
> > > modified files I can boot.
> > >
> > > I have a lot of APIC error on CPU0.
>
> Maybe try booting with noapic and/or nolapic and see if it helps. Tha=
t's
> probably just a workaround and not the right solution though.

No. Booting with noapic doesn't resolve the problem. But now it's a min=
or=20
problem.

> > It seems one of via pci routing quirk problem.  Can you give a shot=
 at
> > 'acpi=3Doff' or 'acpi=3Dnoirq' without 'irqpoll'?
> >
> > I dunno much about what's going on there.  Alan, Jean, any ideas?
>
> I've read the whole thread, the source code (quickly) and the patches=
 to
> ahci.c and sata_via.c, and here are some comments:
>
> It looks like support for the VT8251 was added to the ahci driver in =
kernel
> 2.6.18, and was then updated in 2.6.20. The code is different from th=
e
> patch Leopold is using with 2.6.16. As I am not an expert in this are=
a, I
> can't tell whether both versions are equivalent or not, but I'd guess=
 so.

Probably are equivalent but maybe "the experts"  don't think the same.

> On the other hand, I do not see VT8251 support in the sata_via driver=
 in
> the kernel, so I'm not surprised that it doesn't work properly for Le=
opold.

Well in http://via8251.la-evento.com/index.html=20

<off topic>
please tell me that I'm not violating any rule about the linux-kernel l=
ist=20
putting this link :-S
</off topic>

claims that the VT8251 are supported in 2.6.20. As always you nned to s=
ee the=20
official place .... :-(
 =20
> But again I am no expert in the area, so maybe the sata_via driver in=
 the
> kernel is supposed to work for VT8251-based systems. Jeff (cc'd) shou=
ld
> know better.


> I also see that there were many changes to these drivers post-2.6.20,=
 so
> maybe Leopold could give a try to Linus' latest kernel (2.6.20-git6 a=
s I
> speak) and see if there are any improvements.

Ok, I need some more time to test this.

> As for the VIA IRQ quirks, the version we have in 2.6.20 does not han=
dle
> the VIA chips more recent than the VT8237A. If the VT8251 needs it, t=
hen we
> have to add it. Alan?
>
> *If* the VT8251 needs the VIA IRQ quirk, then the attached patch may =
help.
> Leopold, can you give it a try?

Well, making your patch to the vanilla 2.6.20 the result is the same. T=
he box=20
doesn't boot. Always the same problem ....

Thank's for all,

Regards,

Leo=20
