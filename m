From: Erik Slagter <erik@slagter.name>
Subject: Re: Problems with DMA enabling
Date: Wed, 17 Aug 2005 17:59:14 +0200
Message-ID: <1124294354.5948.18.camel@localhost.localdomain>
References: <1124293208.3885.10.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Rd7b02xjp4P/G+rKlfLR"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:48025 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751153AbVHQQAE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 12:00:04 -0400
In-Reply-To: <1124293208.3885.10.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dbueso@linuxchile.cl
Cc: linux-ide@vger.kernel.org


--=-Rd7b02xjp4P/G+rKlfLR
Content-Type: multipart/mixed; boundary="=-NPobYIwsHGyqR8AUJpJR"


--=-NPobYIwsHGyqR8AUJpJR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-17 at 11:40 -0400, Davidlohr Bueso A. wrote:

> After googling I discovered that the solution for many was changing in
> include/linux/libata.h
>=20
> #undef ATA_ENABLE_ATAPI /* define to enable ATAPI support */=20
> to=20
> #define ATA_ENABLE_ATAPI /* define to enable ATAPI support */

ROFL! Sorry...

You're changing a kernel BUILDING parameter here. It will not have any
effect until you recompile your kernel, so kiss your debian pre-compiled
kernel goodbye ;-)

There are actually several HOWTO's for kernel (re)building, btw.

If you are going to do this, you need to apply this patch as well (see
attachment) or your computer will lock up every now and then.

If you have built the new kernel and booted it, your cd/dvd drive will
now be claimed by libata and show up as /dev/scd0 instead of /dev/hdc
(or similar). Hdparm -d 1 will not work (either), but DMA will be used
anyway.

--=-NPobYIwsHGyqR8AUJpJR
Content-Disposition: inline; filename=satalockup-patch
Content-Type: text/x-patch; name=satalockup-patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9saWJhdGEtc2NzaS5jIGIvZHJpdmVycy9zY3NpL2xp
YmF0YS1zY3NpLmMNCi0tLSBhL2RyaXZlcnMvc2NzaS9saWJhdGEtc2NzaS5jDQorKysgYi9kcml2
ZXJzL3Njc2kvbGliYXRhLXNjc2kuYw0KQEAgLTM4NSw2ICszODUsNyBAQCBpbnQgYXRhX3Njc2lf
ZXJyb3Ioc3RydWN0IFNjc2lfSG9zdCAqaG9zDQoJICogYXBwcm9wcmlhdGUgcGxhY2UNCgkgKi8N
Cglob3N0LT5ob3N0X2ZhaWxlZC0tOw0KKwlJTklUX0xJU1RfSEVBRCgmaG9zdC0+ZWhfY21kX3Ep
Ow0KDQoJRFBSSU5USygiRVhJVFxuIik7DQoJcmV0dXJuIDA7DQo=


--=-NPobYIwsHGyqR8AUJpJR--

--=-Rd7b02xjp4P/G+rKlfLR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDA17SJgD/6j32wUYRAqAPAJ4398OV93GelxPTLztbB/9gXbLFjwCeKWwI
KBe5zawM7M4zFfe9t9Huodw=
=Ro9t
-----END PGP SIGNATURE-----

--=-Rd7b02xjp4P/G+rKlfLR--
