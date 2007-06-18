From: Chr <chunkeey@web.de>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 21:14:24 +0200
Message-ID: <200706182114.25120.chunkeey@web.de>
References: <39B20DF628532344BC7A2692CB6AEE07016FE477@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:51814 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761624AbXFRTO1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 15:14:27 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4E6A389DB2D6
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 21:14:26 +0200 (CEST)
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07016FE477@orsmsx420.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: chunkeey@web.de

On Monday, 18. June 2007, you wrote:
> I don't think we want to have the same DeviceID supported in more the=
n one driver. =A0Would they not conflict with each other?
>=20
> Jason
>=20
please bottom post!

about your concerns:

see: pci_id.h
#define PCI_DEVICE_ID_INTEL_ICH6_19=A0=A0=A0=A0=A00x266f
#define PCI_DEVICE_ID_INTEL_ICH7_21=A0=A0=A0=A0=A00x27df

then look in piix.c:
=A0=A0=A0=A0=A0=A0=A0=A0{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6=
_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
=A0=A0=A0=A0=A0=A0=A0=A0{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7=
_21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 21},

and check ata_piix.c:
=A0=A0=A0=A0=A0=A0=A0=A0/* ICH6 (and 6) (i915) UDMA 100 */
=A0=A0=A0=A0=A0=A0=A0=A0{ 0x8086, 0x266F, PCI_ANY_ID, PCI_ANY_ID, 0, 0,=
 ich_pata_100 },
=A0=A0=A0=A0=A0=A0=A0=A0/* ICH7/7-R (i945, i975) UDMA 100*/
=A0=A0=A0=A0=A0=A0=A0=A0{ 0x8086, 0x27DF, PCI_ANY_ID, PCI_ANY_ID, 0, 0,=
 ich_pata_133 },

unfortunatly, it already happend... worse: it's already in vanilla! any=
 complains? no??????

Thanks,
	Chr.

>=20
>=20
> >-----Original Message-----
> >From: chunkeey@web.de [mailto:chunkeey@web.de]
> >Sent: Monday, June 18, 2007 11:50 AM
> >To: Gaston, Jason D
> >Cc: linux-ide@vger.kernel.org
> >Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
> >
> >On Monday, 18. June 2007, Gaston, Jason D wrote:
> >> FYI: DID 2850 is the PATA IDE controller. =A0Most likely, the lapt=
op does
> >not have SATA drives and is running off of PATA.
> >>
> >> The old IDE subsystem (piix.c) is where I added that PATA DID to.
> >> #define PCI_DEVICE_ID_INTEL_ICH8_6=A00x2850 in pci_ids.h
> >>
> >> Jason
> >>
> >
> >Yes, I've already said that the old IDE subsystem knows about ICH 8M
> >(read the stuff in the brackets in the original post!).
> >
> >But one day the old ide subsystem will be gone...
> >that's why I've added the PCIID to ata_piix.c "today", so I don't ha=
ve to
> >do it "tomorrow".
> >
> >Another thing, Kconfig's description clearly states: "
> >config ATA_PIIX
> >=A0=A0=A0=A0=A0tristate "Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA supp=
ort"
> >...
> >=A0=A0=A0=A0=A0 =A0This option enables support for ICH5/6/7/8 Serial=
 ATA
> >=A0=A0=A0=A0=A0 =A0and support for PATA on the Intel ESB/ICH/PIIX3/P=
IIX4 series
> >=A0=A0=A0=A0=A0 =A0host controllers.
> >"
> >
> >so, either change the description to:
> >"... support for PATA on the Intel ESB/ICH(all old chipsets
> >0,2,3M,3,4,5,6,7,7-R; but
> >not 8M, because you have use the old subsystem, for your "new"
> >technology!)/PIIX3/PIIX4 series"
> >
> >or accept the 1+1=3D2 logic and merge the patch into the git.
> >(hint: but only after changing ich_pata_100 to ich_pata_133 of cours=
e!)
> >
> >:D
> >
> >Thanks,
> >     Chr.
> >
> >>

