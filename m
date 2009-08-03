From: Mark Lord <liml@rtr.ca>
Subject: Re: HighPoint RocketRAID 2320
Date: Mon, 03 Aug 2009 18:51:47 -0400
Message-ID: <4A776A03.90705@rtr.ca>
References: <20090803201836.GD13863@dsg.to> <4A7764D3.1090702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:39616 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbZHCWvs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 18:51:48 -0400
In-Reply-To: <4A7764D3.1090702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>
Cc: linux-ide@vger.kernel.org

Mark Lord wrote:
> Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
>> Hi all,
>>
>> I'm throwing this out here in the hopes that someone smarter than me=
 has
>> a simple solution - never hurts to be optimistic. :)
>>
>> I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA=20
>> fakeraid). It is only supported by an ugly binary blob deceptively=20
>> labeled as an "open source driver" from HighPoint (rr232x). Looking =
at=20
>> the wrapper around the blob, it seems this driver claims only the 23=
20=20
>> and 2322 controllers:
>>
>> static const struct pci_device_id hpt_pci_tbl[] =3D {
>>         {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
>>         {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
>>         {}
>> };
>>
>> I've found that this controller contains a marvell 88SX6081 chip, wh=
ich
>> should be supported by the sata_mv driver. That driver claims device=
 IDs
>> 2300 and 2310:
>>         { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
>>         { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
>>
>> So, ever hopeful, I tried adding the 2320 into the table:
>>         { PCI_VDEVICE(TTI, 0x2320), chip_608x },
>>
>> When I do this, the kernel successfully probes the attached disks an=
d
>> their capacity, but immediately errors out and starts resetting the
>> ports repeatedly.
> ..
>=20
> Send me a clear, in-focus detailed photograph of the board,
> showing the chip markings very clearly.
=2E.

Never mind -- found one here:
http://www.taipeitradeshows.com.tw/downloads/2007051104030512475/RR2320=
=2Ejpg

The SATA chip is clearly a 88SX6091-8CZ, which is a PCIX 8-port control=
ler.
Since it is sitting on a PCIe card, one must assume there's a PCIe-to-P=
CIX
bridge hidden under that huge heatsink.

So if the card does not work in the chip_608x mode,
there's probably some funny business in that bridge chip.

Maybe it works *only* in the proprietary RAID mode (?)

Cheers
