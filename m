From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 08 Apr 2009 12:09:19 +1000
Message-ID: <1239156559.10104.7.camel@localhost>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-eyVJA3ce50KgS5GhPD2w"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.10.76.25]:48277 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733AbZDHCJV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Apr 2009 22:09:21 -0400
In-Reply-To: <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>


--=-eyVJA3ce50KgS5GhPD2w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-07 at 19:36 -0500, Timur Tabi wrote:
> On Tue, Apr 7, 2009 at 6:57 PM, Tejun Heo <tj@kernel.org> wrote:
>=20
> > Hmmm... that means intx isn't set by default.  I'm not sure what is
> > the right thing to do here.  I think it's something which should be
> > handled by the PCI layer.  Oh well, maybe we should just revert the
> > change and keep setting intx?
>=20
> cc'ing linuxppc-dev
>=20
> I really don't know what should be done.  It seems to make sense to
> have the PCI layer enable interrupts.
>=20
> This seems to be a powerpc-specific bug, but I don't know enough of
> the PCI subsystem.

Have you confirmed that INTX is disabled before that call?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-eyVJA3ce50KgS5GhPD2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkncB08ACgkQdSjSd0sB4dIOogCdHN5r2BUzzwDBoSPsmtRgj7B4
MwQAoJXrCUcqEhqSRuB9EFs+TNmjIlWU
=qbzu
-----END PGP SIGNATURE-----

--=-eyVJA3ce50KgS5GhPD2w--

