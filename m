From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: RE : Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 9 Jun 2006 17:55:50 +0200 (CEST)
Message-ID: <20060609155550.69188.qmail@web26907.mail.ukl.yahoo.com>
References: <44898A52.2010008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26907.mail.ukl.yahoo.com ([217.146.176.96]:31067 "HELO
	web26907.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030249AbWFIPzw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 11:55:52 -0400
In-Reply-To: <44898A52.2010008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--- Jeff Garzik wrote:
> >   Your hard disk is a lot more powerfull than what you think, only =
very old
>=20
> No, it's not.  I am well aware of what's in the ATA spec.
>
> >  hard disks only have ATA set max command. Nowadays, you can not on=
ly set the
>=20
> Not true.

  If you want more info without reading the spec, here is some more:
http://www.heise.de/ct/english/05/08/172/

> >  Gujin also do the absolutely needed setup of the IDE hard disk whi=
ch is to freeze
> >  the password system _and_ the config system of all the IDE hard di=
sks present, so
> >  that no virus can put a random password and send you an E-mail wit=
h the address
> >  where to send the money to get the password to unlock the hard dis=
k and so access
> >  again your data. Again, freezing means no more modifiable until ne=
xt power cycle,
> >  so IMO it is the job of the bootloader to setup the hard disk, bef=
ore running
> >  anything like Linux, a commercial OS, a bootable CDROM...
>=20
> This is totally broken, and I am going to strongly recommend that no =
one=20
> use this software.

  But that is the recommended way to do in the ATA specification, since=
 ATA4:

http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
and read "6.10 Security Mode feature set" around page 30 / page 46.
Pay attentiong to the last sentense of "6.10.4 Frozen mode".

  And some BIOS correctly implement it - most BIOS don't.

> It is the OS responsibility to do this.  As a simple example, when th=
e=20
> libata ACPI patches are merged (soon), libata will send BIOS-specifie=
d=20
> taskfiles to the device -- including the hard drive password, if any.=
=20
> Then it will freeze the settings.

  Which setting are you talking about: freezing the HPA, the configurat=
ion
 or the password - that is different ATA commands.
 Gujin can run a kernel (or some other software) without freezing each =
of
 them independantly but the user has to explicitely request it - and sh=
ould
 not try to boot a random CDROM with the password unfrozen.

> Gujin's behavior will prevent the user from accessing their data, if=20
> they have protected it via BIOS.

  Some BIOS have support for password, but Gujin is not using BIOS
 services for "protection" because BIOS is not providing such services
 with a documented interface.

> >  Gujin is assuming that your hard disk are accessible by the docume=
nted ATA ide
> >  system, and some (or all?) IDE SATA interface have (volumtary?) br=
oken
> >  implementation: they are not IDE register compatible.
>=20
> More evidence that Gujin is completely broken.
>=20
> Host controller programming interfaces have _always_ been variable.  =
PCI=20
> IDE standard was never a requirement for all host controllers, indeed=
=20
> such a requirement would be stupid, and widely ignored.
>=20
> Modern SATA controllers are all FIS-based, and are not (and should no=
t=20
> be) limited by the legacy IDE register programming interface.

  The complete ATA specification is describing a register interface sin=
ce ATA1,
 SATA chipsets should be software compatible, even if they add commands=
/interfaces:
http://www.sata-io.org/interopfaq.asp    say:
    Are there any known interoperability issues with SATA?
    One of the primary requirements of the SATA 1.0 specification was t=
o
    maintain backward compatibility with existing operating system driv=
ers
    to eliminate incompatibility issues.


  Etienne.


__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection p=
ossible contre les messages non sollicit=E9s=20
http://mail.yahoo.fr Yahoo! Mail=20
