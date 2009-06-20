From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] PATA driver for CF interface on AT91SAM9260 SoC
Date: Sat, 20 Jun 2009 13:09:47 -0400
Message-ID: <4A3D17DB.30001@garzik.org>
References: <1245181151-7040-1-git-send-email-geomatsi@gmail.com>	<20090618002004.54701b40@realm>	<20090617235351.1cb05c97@lxorguk.ukuu.org.uk>	<20090618222401.462b2d44@realm>	<20090618193720.26830bc8@lxorguk.ukuu.org.uk>	<20090619082740.6986544a@realm> <20090620165439.6314f9ef@realm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46443 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbZFTRJ2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Jun 2009 13:09:28 -0400
In-Reply-To: <20090620165439.6314f9ef@realm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Sergey Lapin <slapin@ossfans.org>, Andrew Victor <avictor.za@gmail.com>

Sergey Matyukevich wrote:
> On Fri, 19 Jun 2009 08:27:40 +0400
> Sergey Matyukevich <geomatsi@gmail.com> wrote:
>=20
>> On Thu, 18 Jun 2009 19:37:20 +0100
>> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>>> Concerning the first point, this module parameter is used in
>>>> driver probing function:=20
>>>> 	ap->pio_mask =3D pio_mask;
>>>>
>>>> I would suggest to keep pio_mask as a module parameter, since it
>>>> might be useful to modify it in order to =D1=81ut down PIO speed, =
e.g.
>>>> for testing purposes.=20
>>> Libata already has general support for that. (Arguably we should
>>> take it out of the pata_legacy driver in the same way)
>>
>> Patch update: module param for pio_mask removed.
>>
>>
>=20
> Hello,
> Is there any chance for this driver to be accepted during current mer=
ge
> window ?

Absolutely...  is this the last revision of the driver (for the moment)=
?

	Jeff



