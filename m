From: Eric Wong <eric@petta-tech.com>
Subject: Re: Silicon Image 3112 h/w docs available
Date: Sat, 23 Oct 2004 12:11:25 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041023191125.GJ9119@mail.petta-tech.com>
References: <41792BC3.9060304@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66.238.42.11.ptr.us.xo.net ([66.238.42.11]:40102 "EHLO
	mail.petta-tech.com") by vger.kernel.org with ESMTP id S261278AbUJWTLc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 23 Oct 2004 15:11:32 -0400
Content-Disposition: inline
In-Reply-To: <41792BC3.9060304@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik <jgarzik@pobox.com> wrote:
>=20
> In order to better support open source developers, Silicon Image has=20
> been kind enough to give me permission to publicly post the hardware=20
> documentation for some of their older SATA chipsets on my docs site,=20
> namely the 3112 in this case:
>=20
> http://gkernel.sourceforge.net/specs/sii/3112A_SiI-DS-0095-B2.pdf.bz2
>=20
> This documentation will assist developers in maintaining the=20
> siimage/sata_sil SATA drivers in the Linux kernel.
>=20
> So now the 311x joins the ranks of "open hardware".  Thanks, SiI!

Doesn't seem to contain any more info on drives/controllers affected by
the mod15write quirk.  I'd like to see firmware revisions added to the
blacklist, and not just model numbers anymore.  I didn't have that
information when I first implemented the blacklist (model numbers only),
and it still doesn't seem to be available right now.

I'm rather disappointed that the drive (ST3160023AS) I use has managed
to get its way onto the blacklist[1].  I'm using rev 3.05 of that drive
with a 3112 (rev 02), and have been for nearly a year at full speed and
have never had problems under heavy read/write usage.  Setups affected
by an uncorrected mod15write bug are corrupted almost immediately, no?

--=20
Eric Wong -- eric@petta-tech.com -- normalperson@yhbt.net

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBeqzdcodMowuNYfcRAhKZAJ9+GEp32Phx+aa9nGndnmE0pSq4fgCfSTq0
6XCUp3UPHYMJbN8zXLJ52t8=
=qSH8
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--
