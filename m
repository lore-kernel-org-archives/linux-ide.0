From: Mark Brown <broonie@kernel.org>
Subject: sata_dwc_460ex build failures in -next
Date: Mon, 12 Jan 2015 12:36:55 +0000
Message-ID: <20150112123655.GF4160@sirena.org.uk>
References: <E1YAZyB-0007iE-CZ@debutante>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52757 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbbALMhE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2015 07:37:04 -0500
Content-Disposition: inline
In-Reply-To: <E1YAZyB-0007iE-CZ@debutante>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2015 at 08:03:27AM +0000, Build bot for Mark Brown wrote:

> 	arm64-allmodconfig
> ../drivers/ata/sata_dwc_460ex.c:719:3: error: implicit declaration of fun=
ction 'dma_cache_sync' [-Werror=3Dimplicit-function-declaration]
>=20
> 	arm-allmodconfig
> ../drivers/ata/sata_dwc_460ex.c:719:3: error: implicit declaration of fun=
ction 'dma_cache_sync' [-Werror=3Dimplicit-function-declaration]

Since commit 84683a7e081ff60e (sata_dwc_460ex: enable COMPILE_TEST for
the driver) the sata_dwc_460ex has been breaking the all*config builds
for arm and arm64 as the driver uses dma_cache_sync() but this function
is not provided on those architectures.

Either a more specific dependency is needed or the function shouldn't be
used, I've not looked at the code.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUs7/nAAoJECTWi3JdVIfQ/TsH/1NCH97BQLYRQWrAp4y77/0k
n4PXCLD5UiMOfVEw/97I5fYEi7vaxiQwM9av97g1QwOlQibTSzDYWkjOlEsUa4Kk
9UGXdz3z+eeLAdbV1sMFfx2LC5CwlYgFrxdliezzkpjB+u+aEktEEfDa2TZD9e9Q
hyLEYJP7DaVKH7sZ4cOf9ZIqCxiqgU/dwn+YVlDYs4qb+vcmYv+sXubHisb/x43p
7QqXbENS3y60C2+9ywX0w9Z2Ru0iIC6VwrB931cG8jADm1mzGRk68q0m8eQtk2/T
5MiJyQFLSnY6Myl+ddk6OwrYWeodCEl8bEZUsPJEwivF/GmqzyYQtsHZn41Vfzw=
=RWk0
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
