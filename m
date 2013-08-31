From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH libata/for-3.11-fixes] libata: make it clear that
 sata_inic162x is experimental
Date: Sat, 31 Aug 2013 21:17:00 +0100
Message-ID: <1377980220.9792.41.camel@deadeye.wl.decadent.org.uk>
References: <20130627165114.GK4752@decadent.org.uk>
	 <1372353297.24346.4.camel@phoenix> <20130627173142.GM4752@decadent.org.uk>
	 <1372375714.330.17.camel@phoenix>
	 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
	 <1372427725.23094.17.camel@phoenix>
	 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
	 <20130701061726.GA10717@mtj.dyndns.org> <1372668742.17064.23.camel@phoenix>
	 <20130722211307.GA16776@mtj.dyndns.org>
	 <20130729165229.GF22605@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-0TtLywh+hP/J/Q8mnLQe"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56107 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381Ab3HaURF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Aug 2013 16:17:05 -0400
In-Reply-To: <20130729165229.GF22605@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 714295@bugs.debian.org, linux-ide@vger.kernel.org, risc4all@yahoo.com, Martin Braure de Calignon <braurede@free.fr>


--=-0TtLywh+hP/J/Q8mnLQe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2013-07-29 at 12:52 -0400, Tejun Heo wrote:
> Hello, Greg.
>=20
> I think the following commit should go into -stable but forgot to cc
> stable.  It's now in Linus' tree.  Can you please include it in
> -stable?
>=20
> Thanks!
>=20
> On Mon, Jul 22, 2013 at 05:13:07PM -0400, Tejun Heo wrote:
> > From bb9696192826a7d9279caf872e95b41bc26c7eff Mon Sep 17 00:00:00 2001
> > From: Tejun Heo <tj@kernel.org>
> > Date: Mon, 22 Jul 2013 16:53:36 -0400
[...]

I've queued this up for 3.2, thanks.

Ben.

--=20
Ben Hutchings
If God had intended Man to program,
we'd have been born with serial I/O ports.

--=-0TtLywh+hP/J/Q8mnLQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIVAwUAUiJPPOe/yOyVhhEJAQot9g//Xztr30/u1uelXq1KpXvP6cBVEiN82y03
EFjw08JWtMX2Xg5/rQRY9q7MITzwFkIP2oQVw/398oPujSH6rL8ptwMKZ5V9LtPx
Jn6pw8n4YgkLRvDbcb0U5ooLAl5gX0gX6W//xN27Is9jIxxtXln3RTcWUiFgrNuA
vDncUZfDeRKYODpl3jyQLNmJv4qcaYKOaaOAK2Blsrq8G141tWQAzlHVL90BUEki
emAYDXAMPq6wkCrufz6mkbs4NY9gdtIBYOsRePMEhMDJbnL6b2F09/5rnh/un1lp
BJC1KcwAw5m0r80I0kEMlfShrDv3RjXeSoJ4GIbkz0yIMTFeyPtrhOJYXiuho4q9
Uo6CEiVql/z+Kh/tUtStYVJcNnNE66GKYsFEruUZqBSW7PLxm86S2mNMtfGgufVN
l3KqLHcp3/FvWv1fpkjZOs7p7EQ+uQg7Mi0gStnqHzjNrmQayBFmv1MHT5vc3+5f
rkuqOZzHDDRZtpeUrD95Nj0nREdCF7mN/aVm5o4BE7JsBHG+TRwxOKUA0fM2QpP/
ahbE5eB+FAaX4DJcZoRp7CGCrEy8y2BddvggptTtcASLufibHxPY2maAO2GVqpo0
CJIbfEd6r0OvcmvZO8nNZVg6+e6AgKQiAY6tf5k9WEv+ur6ePIOP6zc9oKVQXDNa
iJ24ozQG8Dc=
=FerD
-----END PGP SIGNATURE-----

--=-0TtLywh+hP/J/Q8mnLQe--
