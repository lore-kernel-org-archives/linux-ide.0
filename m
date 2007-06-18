From: Chr <chunkeey@web.de>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 20:49:45 +0200
Message-ID: <200706182049.45315.chunkeey@web.de>
References: <39B20DF628532344BC7A2692CB6AEE07016FE477@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:35307 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764344AbXFRStt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:49:49 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07016FE477@orsmsx420.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

On Monday, 18. June 2007, Gaston, Jason D wrote:
> FYI: DID 2850 is the PATA IDE controller.  Most likely, the laptop do=
es not have SATA drives and is running off of PATA. =20
>=20
> The old IDE subsystem (piix.c) is where I added that PATA DID to.
> #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850 in pci_ids.h
>=20
> Jason
>=20

Yes, I've already said that the old IDE subsystem knows about ICH 8M=20
(read the stuff in the brackets in the original post!).

But one day the old ide subsystem will be gone...
that's why I've added the PCIID to ata_piix.c "today", so I don't have =
to do it "tomorrow".

Another thing, Kconfig's description clearly states: "
config ATA_PIIX
	tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support"
=2E..
	  This option enables support for ICH5/6/7/8 Serial ATA
	  and support for PATA on the Intel ESB/ICH/PIIX3/PIIX4 series
	  host controllers.
"

so, either change the description to:
"... support for PATA on the Intel ESB/ICH(all old chipsets 0,2,3M,3,4,=
5,6,7,7-R; but
not 8M, because you have use the old subsystem, for your "new" technolo=
gy!)/PIIX3/PIIX4 series"

or accept the 1+1=3D2 logic and merge the patch into the git.=20
(hint: but only after changing ich_pata_100 to ich_pata_133 of course!)

:D

Thanks,=20
	Chr.
 =20
>
> >On Monday, 18. June 2007, Alan Cox wrote:
> >> On Mon, 18 Jun 2007 15:20:06 +0200
> >> Chr <chunkeey@web.de> wrote:
> >>
> >> > Hi,
> >> >
> >> > I got a new laptop and I had a little problem that the DVD drive=
 wasn't
> >recognized by
> >> > libata's piix driver (but the old IDE Subsystem found it!).
> >> >
> >> > So, after adding the new pciid 8086:2850 it works!
> >> > But, I don't know if it's ich_pata_100 or ich_pata_133 since the
> >> > dvd/cd drives only goes up to udma2 speeds.
> >>
> >> Its ich_pata_133 - all the newer chips are. They work even better =
if you
> >> set them into AHCI mode in the BIOS and then they should "just wor=
k" with
> >> recent kernels as the AHCI driver now matches by class.
> >>
> >> Alan
> >>
> >>
> >
> >No go.. I've tried 2.6.20-1-amd64 (debian sid) and a vanilla 2.6.22-=
rc5.
> >
> >(The "problem" is that there are no options for that in the BIOS.
> >The BIOS itself is only useful on these laptops, if you want to set =
a BIOS
> >password, setting the system clock or change the boot order... and n=
othing
> >else)
> >
> >Thanks,
> >=A0=A0=A0=A0=A0=A0=A0=A0Chr.
> >-
