From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
Date: Fri, 9 Jun 2006 22:41:47 +0200 (CEST)
Message-ID: <20060609204147.61760.qmail@web26912.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web26912.mail.ukl.yahoo.com ([217.146.177.79]:2927 "HELO
	web26912.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965156AbWFIUls (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jun 2006 16:41:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

--- XXXXXXXX wrote:
> It tends to be preferred around here to implement hardware features s=
o=20
> that hardware actually works, rather than to implement spec and blame=
=20
> the hardware for failing to work to the spec.

 Well, the IDE hardware works, and conform to the ATA specs.
 Gujin is using those ATA command for quite a long time.
 I just have a problem with SATA chipset not being ATA1-7 compatible.

>  If, as you say, most BIOS=20
> don't obey the spec, then implementing a spec that bears little=20
> resemblance to actual behavior only helps the small number of=20
> spec-compliant implementations.

  The main problem for BIOS manufacturer is the keyboard mapping
 recognition to enter the password. And there is no real point
 in freezing the password system of a locked drive.
  Gujin try to solve most of those problems, but because it is
 located on the hard disk itself limit the choice - it would be
 so nice to have a big enough BIOS FLASH and put Gujin there.
 Second best choice is having two hard disks (compact flash as
 first HD with compact flash <-> IDE adapter).

> >   The complete ATA specification is describing a register interface=
 since ATA1,
> >  SATA chipsets should be software compatible, even if they add comm=
ands/interfaces:
> > http://www.sata-io.org/interopfaq.asp    say:
> >     Are there any known interoperability issues with SATA?
> >     One of the primary requirements of the SATA 1.0 specification w=
as to
> >     maintain backward compatibility with existing operating system =
drivers
> >     to eliminate incompatibility issues.
> >=20
>=20
> Again with the "The spec says it works this way, so I can do it this=20
> way."  I realize that you can be perfectly, legally, safe implementin=
g=20
> specified behavior, but it leaves you doing what you are doing here,=20
> which is blaming the hardware for not living up to the specification.=
=20

  Well the ATA specs are quite old, Gujin still work with the BIOS hard=
 disk
 so still act as a bootloader, but it can not protecting you against a
 1 milisecond attack setting password.
 By the way the SATA specs are not free.

> It is generally the choice in the linux kernel to make the hardware=20
> work, and ignore the specification where it is irrelevant to actual=20
> functionality.  Read up on the SAS Transport Layer.

  Oh yes, Gujin has some strange code to make things work at the end,
 look for ATAPI stuff - I can and do ignore the specs to make the softw=
are
 work on real hardware.

  Cheers,
  Etienne.



__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection p=
ossible contre les messages non sollicit=E9s=20
http://mail.yahoo.fr Yahoo! Mail=20
