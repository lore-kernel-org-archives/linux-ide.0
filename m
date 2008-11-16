From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: 2.6.28-rc3: WARN_ON(ap->nr_active_links) in ata_eh_finish() with pata_ali DMA CD-ROM
Date: Sun, 16 Nov 2008 21:40:09 +0300
Message-ID: <200811162140.10636.arvidjaar@mail.ru>
References: <200811042128.10356.arvidjaar@mail.ru> <200811161559.08981.arvidjaar@mail.ru> <49203C63.4070803@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2346516.pgoBGfEFfG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx30.mail.ru ([194.67.23.238]:3548 "EHLO mx30.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbYKPSkP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 13:40:15 -0500
In-Reply-To: <49203C63.4070803@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

--nextPart2346516.pgoBGfEFfG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 16 November 2008, Tejun Heo wrote:
> Hello,
>=20
> Andrey Borzenkov wrote:
> > On Tuesday 11 November 2008, Tejun Heo wrote:
> >> Andrey Borzenkov wrote:
> > rc5 is the first release ever that correctly falls back to PIO from DMA
> > on ATAPI connected to pata_ali. Wow! Thank you!
>=20
> Hmm... this should have worked on 2.6.27 too.  How did it fail on
> 2.6.27?
>=20

You are right, I guess I gave up testing ATAPI on pata_ali :)

> pata_ali ATAPI dma problem is sad.  I have the hardware and the ide
> driver works fine and I still can't figure out what's wrong.  :-(
>=20


well, if you need extra tester ...

--nextPart2346516.pgoBGfEFfG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkgaQoACgkQR6LMutpd94zPNwCfbUm/mQTil3ejo6QSefclFJat
WUEAniQCZS3jm9y4cF3sPv6O+2mf2xBx
=Hn3S
-----END PGP SIGNATURE-----

--nextPart2346516.pgoBGfEFfG--
