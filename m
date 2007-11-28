From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
 driver
Date: Wed, 28 Nov 2007 11:41:04 +1100
Message-ID: <20071128114104.3444b012.sfr@canb.auug.org.au>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:53678 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922AbXK1AlM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 19:41:12 -0500
In-Reply-To: <20071127153908.GB14183@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Nov 2007 18:39:08 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +static int __devinit pata_of_platform_probe(struct of_device *ofdev,
> +					    const struct of_device_id *match)
> +{
> +	uint32_t *prop;

Make this "const uint32_t *prop" or (more kernel like) "const u32 *prop" ...

> +	prop =3D (uint32_t *)of_get_property(dn, "ioport-shift", NULL);

then you don't need this cast.  Anytime you use a cast to get rid of
"const", is probably a mistake.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHTLkkTgG2atn1QN8RApj4AJ98KRtWfLTiHUYvFnA017ECyqeX8gCgjhga
HIzwioNIVfMR0fm3OyAJiR4=
=0KEg
-----END PGP SIGNATURE-----

--Signature=_Wed__28_Nov_2007_11_41_04_+1100_qYPJS7h_ChhjmA8a--
