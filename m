From: Richard Mawson <richard@crow.mawsonit.co.uk>
Subject: Re: SATA driver sata_sil24
Date: Sat, 24 Apr 2010 06:10:21 +0100
Message-ID: <20100424051021.GG1883@crow.mawsonit.co.uk>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk> <4BD05043.10709@gmail.com> <20100422223309.GA1883@crow.mawsonit.co.uk> <4BD1129E.6030104@gmail.com> <20100423203446.GF1883@crow.mawsonit.co.uk> <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smarthost01.mail.zen.net.uk ([212.23.3.140]:58451 "EHLO
	smarthost01.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752987Ab0DXJMi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Apr 2010 05:12:38 -0400
Content-Disposition: inline
In-Reply-To: <y2i51f3faa71004231734hbcda3ad5p61798db712cc87c5@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Robert, Tejun,

On Fri, Apr 23, 2010 at 06:34:36PM -0600, Robert Hancock wrote:
> > Having put printk messages all over the driver, I see it currently lock=
s up
> > during this readl call:
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear port RST */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D readl(port + PORT_CTRL_STAT);
> >
> > .. but as this is clearly later on from the previously mentioned stack,=
 I'm
> > starting to suspect that this is failing in random places when talking =
across
> > this pci-pcie bridge. Do you agree that this sounds plausible?
>=20
> I suspect it's something like that - not sure what else could cause
> things to explode at that point..

Thank you for your help with this. I believe this was a hardware problem, a=
s the same
pci-pcie converter with the same pcie sata adapter work perfectly in a diff=
erent=20
system (now why didn't I try that first..?).

--=20
Richard Mawson
Mawson IT Services

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvSfT0ACgkQEqu+mbnN8VKpBQCfZnPV2cHic7WGogyRsij9UVxl
1pMAoIaUDfd4+AY7Rup7PQiVMb8Oi0GU
=zIMc
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
