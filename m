From: Chr <chunkeey@web.de>
Subject: Re: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 15:52:37 +0200
Message-ID: <200706181552.37776.chunkeey@web.de>
References: <200706181520.06682.chunkeey@web.de> <20070618144207.751a254b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:37275 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775AbXFRNwl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 09:52:41 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id E5B9E879CEA1
	for <linux-ide@vger.kernel.org>; Mon, 18 Jun 2007 15:52:39 +0200 (CEST)
In-Reply-To: <20070618144207.751a254b@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: chunkeey@web.de

On Monday, 18. June 2007, Alan Cox wrote:
> On Mon, 18 Jun 2007 15:20:06 +0200
> Chr <chunkeey@web.de> wrote:
>=20
> > Hi,
> >=20
> > I got a new laptop and I had a little problem that the DVD drive wa=
sn't recognized by
> > libata's piix driver (but the old IDE Subsystem found it!).
> >=20
> > So, after adding the new pciid 8086:2850 it works!
> > But, I don't know if it's ich_pata_100 or ich_pata_133 since the=20
> > dvd/cd drives only goes up to udma2 speeds.
>=20
> Its ich_pata_133 - all the newer chips are. They work even better if =
you
> set them into AHCI mode in the BIOS and then they should "just work" =
with
> recent kernels as the AHCI driver now matches by class.
>=20
> Alan
>=20
>=20

No go.. I've tried 2.6.20-1-amd64 (debian sid) and a vanilla 2.6.22-rc5=
=2E

(The "problem" is that there are no options for that in the BIOS.=20
The BIOS itself is only useful on these laptops, if you want to set a B=
IOS
password, setting the system clock or change the boot order... and noth=
ing else)

Thanks,
=A0=A0=A0=A0=A0=A0=A0=A0Chr.
