From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [4/12]
Date: Fri, 11 Jun 2004 14:11:06 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040611181106.GB12953@linux-sh.org>
References: <200406111755.02325.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.golden.net ([199.166.210.31]:1037 "EHLO smtp.golden.net")
	by vger.kernel.org with ESMTP id S264277AbUFKSLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jun 2004 14:11:14 -0400
Content-Disposition: inline
In-Reply-To: <200406111755.02325.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 11, 2004 at 05:55:02PM +0200, Bartlomiej Zolnierkiewicz wrote:
> [PATCH] ide: kill hw_regs_t->dma
>=20
> hw_regs_t->dma is needed only by icside.c so make it local to this driver
> (add unsigned int dma to struct icside_state) and kill it from hw_regs_t.
> This allows us also to remove arm specific NO_DMA define from <linux/ide.=
h>.
>=20
sh will be making use of this as well for multiple drivers. Obviously we
can make this local to each driver though if that's going to be the
preferred approach.


--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyfW61K+teJFxZ9wRAqbyAJ9Oya/okUli57KndDDQTkmeAZjGiwCfbJKF
h1PPl9ODjVaD9JaRw+RwEck=
=3BmS
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
