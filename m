From: Mark Lord <liml@rtr.ca>
Subject: Re: HighPoint RocketRAID 2320
Date: Mon, 03 Aug 2009 18:29:39 -0400
Message-ID: <4A7764D3.1090702@rtr.ca>
References: <20090803201836.GD13863@dsg.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:34038 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbZHCW3k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 18:29:40 -0400
In-Reply-To: <20090803201836.GD13863@dsg.to>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>
Cc: linux-ide@vger.kernel.org

Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
> Hi all,
>=20
> I'm throwing this out here in the hopes that someone smarter than me =
has
> a simple solution - never hurts to be optimistic. :)
>=20
> I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA fake=
raid). It is only supported by an ugly binary blob deceptively labeled =
as an "open source driver" from HighPoint (rr232x). Looking at the wrap=
per around the blob, it seems this driver claims only the 2320 and 2322=
 controllers:
>=20
> static const struct pci_device_id hpt_pci_tbl[] =3D {
>         {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
>         {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
>         {}
> };
>=20
> I've found that this controller contains a marvell 88SX6081 chip, whi=
ch
> should be supported by the sata_mv driver. That driver claims device =
IDs
> 2300 and 2310:
>         { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
>         { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
>=20
> So, ever hopeful, I tried adding the 2320 into the table:
>         { PCI_VDEVICE(TTI, 0x2320), chip_608x },
>=20
> When I do this, the kernel successfully probes the attached disks and
> their capacity, but immediately errors out and starts resetting the
> ports repeatedly.
=2E.

Send me a clear, in-focus detailed photograph of the board,
showing the chip markings very clearly.

Thanks

-ml
