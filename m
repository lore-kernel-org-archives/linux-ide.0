From: Mark Lord <liml@rtr.ca>
Subject: Re: HighPoint RocketRAID 2320
Date: Mon, 03 Aug 2009 21:50:34 -0400
Message-ID: <4A7793EA.1050302@rtr.ca>
References: <20090803201836.GD13863@dsg.to> <4A7764D3.1090702@rtr.ca> <4A776A03.90705@rtr.ca> <4A776A80.5090409@rtr.ca> <20090803233519.GF13863@dsg.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:36022 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616AbZHDBue (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 21:50:34 -0400
In-Reply-To: <20090803233519.GF13863@dsg.to>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RGF2w63DsCBTdGVpbm4gR2VpcnNzb24=?= <david@dsg.to>
Cc: linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>

Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
> Hi Mark, thanks for the reply.
>=20
> On Mon, Aug 03, 2009 at 06:53:52PM -0400, Mark Lord wrote:
>> Mark Lord wrote:
>>> Mark Lord wrote:
>>>> Dav=C3=AD=C3=B0 Steinn Geirsson wrote:
>>>>> Hi all,
>>>>>
>>>>> I'm throwing this out here in the hopes that someone smarter than=
 me has
>>>>> a simple solution - never hurts to be optimistic. :)
>>>>>
>>>>> I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA =
=20
>>>>> fakeraid). It is only supported by an ugly binary blob deceptivel=
y =20
>>>>> labeled as an "open source driver" from HighPoint (rr232x). Looki=
ng=20
>>>>> at the wrapper around the blob, it seems this driver claims only=20
>>>>> the 2320 and 2322 controllers:
>>>>>
>>>>> static const struct pci_device_id hpt_pci_tbl[] =3D {
>>>>>         {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
>>>>>         {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
>>>>>         {}
>>>>> };
>>>>>
>>>>> I've found that this controller contains a marvell 88SX6081 chip,=
 which
>>>>> should be supported by the sata_mv driver. That driver claims dev=
ice IDs
>>>>> 2300 and 2310:
>>>>>         { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
>>>>>         { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
>>>>>
>>>>> So, ever hopeful, I tried adding the 2320 into the table:
>>>>>         { PCI_VDEVICE(TTI, 0x2320), chip_608x },
>>>>>
>>>>> When I do this, the kernel successfully probes the attached disks=
 and
>>>>> their capacity, but immediately errors out and starts resetting t=
he
>>>>> ports repeatedly.
>>>> ..
>>>>
>>>> Send me a clear, in-focus detailed photograph of the board,
>>>> showing the chip markings very clearly.
>>> ..
>>>
>>> Never mind -- found one here:
>>> http://www.taipeitradeshows.com.tw/downloads/2007051104030512475/RR=
2320.jpg
>>>
>>> The SATA chip is clearly a 88SX6091-8CZ, which is a PCIX 8-port con=
troller.
>>                             ^^^^^^^^
>> That was supposed to say 88SX6081 there.  :)
>=20
> Ah, I see. I hadn't checked the datasheet, but it is indeed.
>=20
>>> Since it is sitting on a PCIe card, one must assume there's a PCIe-=
to-PCIX
>>> bridge hidden under that huge heatsink.
>>>
>>> So if the card does not work in the chip_608x mode,
>>> there's probably some funny business in that bridge chip.
>>>
>>> Maybe it works *only* in the proprietary RAID mode (?)
>=20
> I found some better chip pics (minus heatsink) here:
> http://www.pcdvd.com.tw/showthread.php?t=3D788031&page=3D3&pp=3D10
>=20
> It shows that under the heatsink is an Intel QG41210 serial-to-parall=
el
> PCI bridge. I found it's datasheet here:
> http://www.intel.com/design/bridge/datashts/27887505.pdf
>=20
> Hope this helps. :)
>=20
> Is there any more debugging information I could send that could help
> diagnose this?
=2E.

How about "lspci -vv", to go with the other info.

Then, perhaps Saeed Bishara from Marvell could have a peek ?
I'm on holiday for the next week and a bit, and Marvell is in arrears
for earlier work on this driver.

Cheers
