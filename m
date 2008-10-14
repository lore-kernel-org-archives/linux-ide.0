From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 07:07:28 +0200
Message-ID: <20081014070728.386a9cf2@mjolnir.drzeus.cx>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
	<48F3D8E2.8000006@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-1176-1223960856-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:36926 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751760AbYJNFHg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 01:07:36 -0400
In-Reply-To: <48F3D8E2.8000006@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-1176-1223960856-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2008 08:25:22 +0900
Tejun Heo <tj@kernel.org> wrote:

> Pierre Ossman wrote:
> > When I'm accessing a single disk, the bandwidth is 70 - 80 MiB/s. When
> > I access a second disk, the bandwidth is about 50 MiB/s/disk, and all
> > five results in 25 MiB/s/disk. In other words, something is limiting
> > things to about 100 MiB/s. Now the question is what that limiting
> > factor is.
> >=20
>=20
> That's the limit of sil3124/3132.  Dunno why but you can't go over that.

Bummer. Is this per port, or is it the PCIe side of the chip that is
limited to this speed?

What do the silicon image guys have to say about it?

>  There's 3132-2 chip on the market.  Maybe it's worth a try?
>=20

Now that model number was not something that was easily found on
google, nor on silicon image's website. Know of any boards with that
chip?

Rgds
--=20
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-1176-1223960856-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkj0KRUACgkQ7b8eESbyJLg1hwCeOkUsOerMxNEJWdNzate/RLFf
z1sAoJOgc3PpLIrU4b0TCOBWg3DWczU9
=dPQs
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-1176-1223960856-0001-2--
