From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [regression] sata_mv: harddisk activity led no longer
	responsive on QNAP TS-109
Date: Fri, 29 Aug 2008 09:47:20 +0800
Message-ID: <20080829014719.GR5990@prithivi.gnumonks.org>
References: <200808261045.33241.elendil@planet.nl> <200808281125.14012.elendil@planet.nl> <c70ff3ad0808280353n18967a9frf414091ae768030c@mail.gmail.com> <200808281911.28484.elendil@planet.nl> <da824cf30808281026x1dde9a5bl1dd779b99b2c2789@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tVmo9FyGdCe4F4YN"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:45326 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYH2BuP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 21:50:15 -0400
Content-Disposition: inline
In-Reply-To: <da824cf30808281026x1dde9a5bl1dd779b99b2c2789@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Frans Pop <elendil@planet.nl>, saeed bishara <saeed.bishara@gmail.com>, linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>


--tVmo9FyGdCe4F4YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2008 at 10:26:32AM -0700, Grant Grundler wrote:
> I still have a patch outstanding against mmio_test fix to issues with
> 64-bit addressing from 32-bit user space. I've attached those (and
> cc'd Harald Welte) in case that's the problem.

Thanks, I'll merge your patches to mmio_test right now.

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--tVmo9FyGdCe4F4YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIt1UnXaXGVTD0i/8RAj9hAKCK0UQWRnD5xWWypPyXq6WWV6bgzACgtSbI
TnUtL4KvqBtw+cNl1xJJLC0=
=mhWE
-----END PGP SIGNATURE-----

--tVmo9FyGdCe4F4YN--
