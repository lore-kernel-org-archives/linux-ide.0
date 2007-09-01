From: Krzysztof Oledzki <olel@ans.pl>
Subject: Re: Should sata_mv work with Highpoint RocketRAID 2300?
Date: Sat, 01 Sep 2007 15:46:56 +0200
Message-ID: <46D96D50.3080600@ans.pl>
References: <46C1DCBB.9020308@double-you.de>	<20070814184301.3201d162@the-village.bc.nu>	<46C2047D.4040901@double-you.de>	<20070815002447.40f7f206@the-village.bc.nu>	<46CE8CC7.4080900@double-you.de>	<46CEAB1B.9060908@garzik.org> <20070824144858.384b1040@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pigeon.axelspringer.pl ([195.177.210.68]:53710 "EHLO
	mx1.axelspringer.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbXIANq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Sep 2007 09:46:58 -0400
In-Reply-To: <20070824144858.384b1040@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Karim 'Kasi Mir' Senoucci <ks@double-you.de>, linux-ide@vger.kernel.org

On 2007-08-24 15:48, Alan Cox wrote:
> On Fri, 24 Aug 2007 05:55:39 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
>=20
>> Karim 'Kasi Mir' Senoucci wrote:
>>> Alan Cox schrieb:
>>>>> in the sata_mv source. Should I add something like:
>>>>>
>>>>>         { PCI_VDEVICE(TTI, 0x2300), chip_604x }
>=20
>> You need to use the sata_mv from kernel 2.6.23-rcX.
>>
>> Patching into older drivers isn't guaranteed to work.
>=20
> May also be the actual chip on the 2300 is different to the older one=
s
> and isn't a 604x.

Indeed, it seems to be a 7042:

http://www.highpoint-tech.com/image/products/SATAII/RR2300_Card_big.jpg

Best regards,

				Krzysztof Ol=EAdzki

