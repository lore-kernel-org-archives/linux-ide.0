From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: RE : Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 9 Jun 2006 22:10:54 +0200 (CEST)
Message-ID: <20060609201054.13944.qmail@web26904.mail.ukl.yahoo.com>
References: <1149873734.22124.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26904.mail.ukl.yahoo.com ([217.146.176.93]:15989 "HELO
	web26904.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030478AbWFIUKz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 16:10:55 -0400
In-Reply-To: <1149873734.22124.40.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >  Gujin is assuming that your hard disk are accessible by the docume=
nted ATA ide
> >  system, and some (or all?) IDE SATA interface have (volumtary?) br=
oken
> >  implementation: they are not IDE register compatible.
>=20
> SFF was never a formal standard, and ST-506 was a random vendor
> interface copying exercise that caught on. ACPI permits the firmware =
to
> provide ATA taskfiles but afaik not the boot loader unfortunately.

  I can understand that 10+ years old interface can be updated, or even=
 redesigned,
 but when you buy the hardware you should be aware that it is not at al=
l compatible
 (maybe some chipset only), so you can decide what to buy. If the spec =
of your
 hardware say that it is 100% compatible and the chipset do not impleme=
nt its spec,
 you have a problem.
  It is mainly to increase the bandwidth of the pipe linking the hard d=
isk to the
 memory, but anyway the hard disk cannot reach this bandwidth for ATA a=
nyway (unless
 reading it own memory cache).
  And there is still the current hardware ATA + ATA disk to manage.

> A lot of newer SATA hardware uses a common standard defined interface
> called AHCI, and it appears most vendors are migrating in the directi=
on
> of using AHCI. If so then we are in the same kind of flux as the VLB
> world before SFF and PCI settled the standard interfaces down for a
> while.
> Don't see how your HPA code protects versus password locking however.=
 If
> I hack the OS I write a new boot block which locks the disk then rebo=
ot
> into it. By the time you go for your floppy its too late.

 If someone has write access to the MBR and the power supply, well he c=
an destroy
 the system in so many ways. Note that if the hard disk has an IDE pass=
word
 that you know and that the disk is frozzen, your new boot block has to=
 enter
 the known-by-you password first...
 Gujin cannot set an IDE password (use other utilities for that), but w=
ill ask
 you the password of locked hard disks (after keyboard mapping/language=
 recognition)
 before probing them for partiton.

> If thats not the case I'm most interested how you set it up to avoid
> this.
>=20
> Alan
>=20

  Etienne.

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection p=
ossible contre les messages non sollicit=E9s=20
http://mail.yahoo.fr Yahoo! Mail=20
