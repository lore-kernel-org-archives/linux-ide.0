From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: HighPoint RocketRAID 2320
Date: Tue, 4 Aug 2009 00:20:33 +0100
Message-ID: <20090803232032.GH16303@trinity.fluff.org>
References: <20090803201836.GD13863@dsg.to> <4A7764D3.1090702@rtr.ca> <4A776A03.90705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:47444 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbZHCXUq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 19:20:46 -0400
Content-Disposition: inline
In-Reply-To: <4A776A03.90705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>, linux-ide@vger.kernel.org

On Mon, Aug 03, 2009 at 06:51:47PM -0400, Mark Lord wrote:
> Mark Lord wrote:
> >Dav=ED=F0 Steinn Geirsson wrote:
> >>Hi all,
> >>
> >>I'm throwing this out here in the hopes that someone smarter than m=
e has
> >>a simple solution - never hurts to be optimistic. :)
> >>
> >>I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA=20
> >>fakeraid). It is only supported by an ugly binary blob deceptively=20
> >>labeled as an "open source driver" from HighPoint (rr232x). Looking=
 at=20
> >>the wrapper around the blob, it seems this driver claims only the 2=
320=20
> >>and 2322 controllers:
> >>
> >>static const struct pci_device_id hpt_pci_tbl[] =3D {
> >>        {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
> >>        {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
> >>        {}
> >>};
> >>
> >>I've found that this controller contains a marvell 88SX6081 chip, w=
hich
> >>should be supported by the sata_mv driver. That driver claims devic=
e IDs
> >>2300 and 2310:
> >>        { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
> >>        { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
> >>
> >>So, ever hopeful, I tried adding the 2320 into the table:
> >>        { PCI_VDEVICE(TTI, 0x2320), chip_608x },
> >>
> >>When I do this, the kernel successfully probes the attached disks a=
nd
> >>their capacity, but immediately errors out and starts resetting the
> >>ports repeatedly.
> >..
> >
> >Send me a clear, in-focus detailed photograph of the board,
> >showing the chip markings very clearly.
> ..
>=20
> Never mind -- found one here:
> http://www.taipeitradeshows.com.tw/downloads/2007051104030512475/RR23=
20.jpg
>=20
> The SATA chip is clearly a 88SX6091-8CZ, which is a PCIX 8-port contr=
oller.
> Since it is sitting on a PCIe card, one must assume there's a PCIe-to=
-PCIX
> bridge hidden under that huge heatsink.

that's an awfully large heatsink, it would be interesting to find out
what is actually under it, in case there is some sort of processor
hidden here.

--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

