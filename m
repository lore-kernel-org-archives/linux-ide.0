From: =?iso-8859-1?B?RGF27fA=?= Steinn Geirsson <david@dsg.to>
Subject: Re: HighPoint RocketRAID 2320
Date: Mon, 3 Aug 2009 23:35:19 +0000
Message-ID: <20090803233519.GF13863@dsg.to>
References: <20090803201836.GD13863@dsg.to> <4A7764D3.1090702@rtr.ca> <4A776A03.90705@rtr.ca> <4A776A80.5090409@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o71xDhNo7p97+qVi"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gozer.dsg.to ([79.171.98.146]:50026 "EHLO gozer.dsg.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbZHCXfW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Aug 2009 19:35:22 -0400
Content-Disposition: inline
In-Reply-To: <4A776A80.5090409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org


--o71xDhNo7p97+qVi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark, thanks for the reply.

On Mon, Aug 03, 2009 at 06:53:52PM -0400, Mark Lord wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> Dav=ED=F0 Steinn Geirsson wrote:
>>>> Hi all,
>>>>
>>>> I'm throwing this out here in the hopes that someone smarter than me h=
as
>>>> a simple solution - never hurts to be optimistic. :)
>>>>
>>>> I have a HighPoint controller, RocketRAID 2320 (8-port PCIe SATA =20
>>>> fakeraid). It is only supported by an ugly binary blob deceptively =20
>>>> labeled as an "open source driver" from HighPoint (rr232x). Looking=20
>>>> at the wrapper around the blob, it seems this driver claims only=20
>>>> the 2320 and 2322 controllers:
>>>>
>>>> static const struct pci_device_id hpt_pci_tbl[] =3D {
>>>>         {PCI_DEVICE(0x1103, 0x2320), 0, 0, 0},
>>>>         {PCI_DEVICE(0x1103, 0x2322), 0, 0, 0},
>>>>         {}
>>>> };
>>>>
>>>> I've found that this controller contains a marvell 88SX6081 chip, which
>>>> should be supported by the sata_mv driver. That driver claims device I=
Ds
>>>> 2300 and 2310:
>>>>         { PCI_VDEVICE(TTI, 0x2300), chip_7042 },
>>>>         { PCI_VDEVICE(TTI, 0x2310), chip_7042 },
>>>>
>>>> So, ever hopeful, I tried adding the 2320 into the table:
>>>>         { PCI_VDEVICE(TTI, 0x2320), chip_608x },
>>>>
>>>> When I do this, the kernel successfully probes the attached disks and
>>>> their capacity, but immediately errors out and starts resetting the
>>>> ports repeatedly.
>>> ..
>>>
>>> Send me a clear, in-focus detailed photograph of the board,
>>> showing the chip markings very clearly.
>> ..
>>
>> Never mind -- found one here:
>> http://www.taipeitradeshows.com.tw/downloads/2007051104030512475/RR2320.=
jpg
>>
>> The SATA chip is clearly a 88SX6091-8CZ, which is a PCIX 8-port controll=
er.
>                             ^^^^^^^^
> That was supposed to say 88SX6081 there.  :)

Ah, I see. I hadn't checked the datasheet, but it is indeed.

>
>> Since it is sitting on a PCIe card, one must assume there's a PCIe-to-PC=
IX
>> bridge hidden under that huge heatsink.
>>
>> So if the card does not work in the chip_608x mode,
>> there's probably some funny business in that bridge chip.
>>
>> Maybe it works *only* in the proprietary RAID mode (?)

I found some better chip pics (minus heatsink) here:
http://www.pcdvd.com.tw/showthread.php?t=3D788031&page=3D3&pp=3D10

It shows that under the heatsink is an Intel QG41210 serial-to-parallel
PCI bridge. I found it's datasheet here:
http://www.intel.com/design/bridge/datashts/27887505.pdf

Hope this helps. :)

Is there any more debugging information I could send that could help
diagnose this?

>>
>> Cheers
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Kind regards,
--=20
Dav=ED=F0 Steinn Geirsson
david@dsg.to

--o71xDhNo7p97+qVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFKd3Q31zX4pjkhuygRArtgAKCPUw9ncOQ+dsyP0w+PY9oJgzYpJgCffWv1
vq7F34nD5beshPS7A6cxD/U=
=ohO6
-----END PGP SIGNATURE-----

--o71xDhNo7p97+qVi--
