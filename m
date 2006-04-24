From: Reinhard =?iso-8859-1?q?Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: sata_via and SATA DVD drive (PX-712SA)
Date: Mon, 24 Apr 2006 17:03:11 +0200
Message-ID: <200604241703.14923.r.brandstaedter@gmx.at>
References: <200604202020.22010.r.brandstaedter@gmx.at> <200604212320.30854.r.brandstaedter@gmx.at> <444C9EED.3000306@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1981676.xk7m4loIVq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.noc.eunet-ag.at ([193.154.160.116]:19948 "EHLO
	smtp2.noc.eunet-ag.at") by vger.kernel.org with ESMTP
	id S1750713AbWDXPcR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Apr 2006 11:32:17 -0400
Received: from melchior.redchili.dyndns.org (redchili.dyndns.org [193.154.186.156])
	by smtp2.noc.eunet-ag.at (Postfix) with ESMTP id 25C79399DA
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 17:32:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 64D1D3E15
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 17:34:34 +0200 (CEST)
Received: from melchior.redchili.dyndns.org ([127.0.0.1])
 by localhost (melchior.redchili.dyndns.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 30276-05-2 for <linux-ide@vger.kernel.org>;
 Mon, 24 Apr 2006 17:34:34 +0200 (CEST)
Received: from [192.168.1.89] (unknown [192.168.1.89])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by melchior.redchili.dyndns.org (Postfix) with ESMTP id 0F1163DD3
	for <linux-ide@vger.kernel.org>; Mon, 24 Apr 2006 17:34:34 +0200 (CEST)
In-Reply-To: <444C9EED.3000306@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com

--nextPart1981676.xk7m4loIVq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 April 2006 11:48, Albert Lee wrote:
> Reinhard Brandst=E4dter wrote:
> > On Friday 21 April 2006 09:24, Albert Lee wrote:
> >>From the dmesg, PX-712SA looks like a PATA drive bridged to SATA.
> >>Could you try the atapi_dmadir=3D1 module parameter and check if it hel=
ps?
> >>(For older kernels, please #define ATAPI_ENABLE_DMADIR
> >>in include/linux/libata.h and recompile the kernel.)
> >
> > Indeed the PX-712SA is a bridged PATA drive. In the POST message it's
> > even reported as PX-712A (the ATAPI model).
> > I've tried to pass libata.atapi_dmadir=3D1 to the kernel but looking at
> > dmesg nothing changed (using kernel 2.6.16). I even changed libata.h and
> > defined ATAPI_ENABLE_DMADIR - same result.
> >
> > What else could I try?
>
> So, it is not the DMADIR problem...
>
> According to the Plextor website
> (http://www.plextor.com/English/support/media_712SA.htm),
> the PX-712SA works with VIA SATA only in PIO mode.
> (The website doesn't say why.)
>
> Maybe updating the firmware of PX-712SA can help?
> Otherwise, please try the attached patch to blacklist
> PX-712SX DMA for sata_via.

Strange I didn't come accross this Plextor support site before.
The most obvios thing I didn't check.

Bad news for me & that drive tough.
I've got a PCI device card SATA controller (PDC20375 TX2plus, sata_promise)=
=20
which the drive should work with.

I'll try both, change the Hardware and apply the blacklist patch.

I've got the latest firmware (1.08) on the drive, doesn't change a thing.

Reinhard



--nextPart1981676.xk7m4loIVq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETOiykeAWQwM7gdsRAvwdAJsHDZNoOOxMvyWUmGEEUL1Jb8XW5QCgh2w0
Peh0Mjm0av+kxWVmJMN6Phw=
=pB9m
-----END PGP SIGNATURE-----

--nextPart1981676.xk7m4loIVq--
