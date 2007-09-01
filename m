From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Sat, 01 Sep 2007 15:38:43 +0200
Message-ID: <46D96B63.7050302@ans.pl>
References: <20070709143841.133abb71@the-village.bc.nu>	<46B08F5F.9040500@garzik.org> <20070801164603.456f1540@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pigeon.axelspringer.pl ([195.177.210.68]:63301 "EHLO
	mx1.axelspringer.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbXIANua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 09:50:30 -0400
In-Reply-To: <20070801164603.456f1540@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, akpm@osdl.org

On 2007-08-01 17:46, Alan Cox wrote:
> On Wed, 01 Aug 2007 09:49:19 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
>=20
>> Alan Cox wrote:
>>> Underneath all the HPT packaging, PCI identifiers, binary driver mo=
dules
>>> and stuff you find that ...
>>>
>>> Signed-off-by: Alan Cox <alan@redhat.com>
>>>
>>> --- drivers/ata/sata_mv.c~	2007-07-09 13:19:57.003052904 +0100
>>> +++ drivers/ata/sata_mv.c	2007-07-09 13:19:57.004052752 +0100
>>> @@ -573,6 +573,9 @@
>>>  	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
>>>  	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
>>>  	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
>>> +	/* RocketRAID 1740/174x have different identifiers */
>>> +	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
>>> +	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },
>> Is this still a test patch, or can it go upstream?
>=20
> Upstream

Are you sure that 1740/1742 are 508x (GEN I)? According to these [1]=20
pictures there may be a 6042 chipset (GEN IIe) placed onboard.

[1] http://www.highpoint-tech.com/image/products/SATAII/RR1740_card_big=
=2Ejpg
http://www.highpoint-tech.com/image/products/eSATA/RR1742_card_big.jpg

Best regards,

				Krzysztof Ol=EAdzki
