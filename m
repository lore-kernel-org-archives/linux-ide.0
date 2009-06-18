From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PATA driver for CF interface on AT91SAM9260 SoC
Date: Thu, 18 Jun 2009 19:37:20 +0100
Message-ID: <20090618193720.26830bc8@lxorguk.ukuu.org.uk>
References: <1245181151-7040-1-git-send-email-geomatsi@gmail.com>
	<20090618002004.54701b40@realm>
	<20090617235351.1cb05c97@lxorguk.ukuu.org.uk>
	<20090618222401.462b2d44@realm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55558 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752143AbZFRSgY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jun 2009 14:36:24 -0400
In-Reply-To: <20090618222401.462b2d44@realm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Sergey Lapin <slapin@ossfans.org>, Andrew Victor <avictor.za@gmail.com>

> Concerning the first point, this module parameter is used in driver
> probing function:=20
> 	ap->pio_mask =3D pio_mask;
>=20
> I would suggest to keep pio_mask as a module parameter, since it migh=
t
> be useful to modify it in order to =D1=81ut down PIO speed, e.g. for =
testing
> purposes.=20

Libata already has general support for that. (Arguably we should take i=
t
out of the pata_legacy driver in the same way)


>=20
> Concerning the second point, I removed set_smc_timing/set_smc_mode fr=
om
> driver probing function.
>=20
> Here is updated patch:

Thanks
