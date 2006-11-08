From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
Subject: Re: sata_mv 7042 support and port multipliers
Date: Wed, 8 Nov 2006 05:35:11 -0800
Message-ID: <20061108133511.GH16523@curie-int.orbis-terrarum.net>
References: <20061106043114.GO15897@curie-int.orbis-terrarum.net> <454ED4A0.2090408@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.isohunt.com ([69.64.61.20]:61616 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S965668AbWKHNfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 08:35:04 -0500
Content-Disposition: inline
In-Reply-To: <454ED4A0.2090408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2006 at 01:22:24AM -0500, Jeff Garzik wrote:
> That's what I had to do.  I have the docs, which cover the programming=20
> interface, but it doesn't cover a lot of the associated errata.  I had=20
> to dig that out of the mvSata driver myself.
>=20
> I had thought that Mark Lord was working on improving sata_mv, but=20
> outside of a locking bugfixes, I haven't seen anything since mid-May.
>=20
> So I guess sata_mv is in limbo again...
Ok, since Mark says he doesn't have the 6081 anymore I guess if I want
this working at all, I get to write and maintain it myself :-).

Are those Marvell docs under some form of protection (NDA etc)? Can I
get a copy of them? There a few questions (around NCQ/PMP) that the
mvSata driver raises for me, and I think the docs would help there.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=3Dpeople.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFUd0PPpIsIjIzwiwRAtFyAKDvEryiWRfKMdlRIz94KK6b5/KYHwCghqAu
M6ONTC8ywPuJmmu3pQwxNts=
=sbVP
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
