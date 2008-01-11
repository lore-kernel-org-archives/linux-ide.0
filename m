From: Tejun Heo <htejun@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Fri, 11 Jan 2008 12:53:14 +0900
Message-ID: <4786E82A.7010208@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:31380 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbYAKDxV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 22:53:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so795959rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 19:53:20 -0800 (PST)
In-Reply-To: <200801101824.04863.Tobias_Mueller@twam.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Tobias_M=FCller?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org

Tobias M=FCller wrote:
> Hello!
>=20
> I'm running 2.6.24-rc7 with an Addonics AD4CFPRJ Quad-CF PCI Controll=
er=20
> (http://www.addonics.com/products/flash_memory_reader/ad4cfprj.asp) u=
sing=20
> Silicon Image PCI0680 chipset which is connected direct (no cables) w=
ith 2=20
> Compact-Flash Cards.
>=20
> In configured
> CONFIG_ATA=3Dy
> CONFIG_PATA_SIL680=3Dy
>=20
> and the controller is correclty found, but it complains about 40-wire=
 cables,=20
> but I'm not using any cables
> at all.
>=20
> Is there a solution to disable this check or to correct this?

The usual way to correct this is to add a whitelist to override cable
detection.  Laptops can be identified using dmi data and add-on cards
hopefully with subsystem.  Dang...  Addonics didn't set Subsystem.

I don't know very well about CF but does it even fill UDMA/33?  What
does 'dd if=3D/dev/sdc of=3D/dev/null bs=3D1M count=3D16 iflag=3Ddirect=
' say?  You
can increase count for more reliable result.

--=20
tejun
