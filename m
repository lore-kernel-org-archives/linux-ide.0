From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: How to determine performance bottleneck?
Date: Tue, 14 Oct 2008 08:03:04 +0200
Message-ID: <20081014080304.65445c51@mjolnir.drzeus.cx>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
	<48F3D8E2.8000006@kernel.org>
	<20081014070728.386a9cf2@mjolnir.drzeus.cx>
	<48F43025.8050705@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-1662-1223964192-0001-2"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.drzeus.cx ([85.8.24.28]:44905 "EHLO smtp.drzeus.cx"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752522AbYJNGDM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 02:03:12 -0400
In-Reply-To: <48F43025.8050705@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-1662-1223964192-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2008 14:37:41 +0900
Tejun Heo <tj@kernel.org> wrote:

> Pierre Ossman wrote:
> >=20
> > Bummer. Is this per port, or is it the PCIe side of the chip that is
> > limited to this speed?
>=20
> I think it's on the host bus side.
>=20
> > What do the silicon image guys have to say about it?
>=20
> ISTR they confirmed the problem but I don't remember talking too much
> about it.
>=20

The optimist in me was hoping that this could be a problem that can be
sidestepped with a clever enough implementation. :)

> >>  There's 3132-2 chip on the market.  Maybe it's worth a try?
> >
> > Now that model number was not something that was easily found on
> > google, nor on silicon image's website. Know of any boards with that
> > chip?
>=20
> Somebody wrote me an email about it.  Looking up... eh.. can't find.  Sor=
ry.
>=20

Do you remember if that's a new chip designation, or 3132 (rev 02)?
Just so I know what to keep an eye out for.

Rgds
--=20
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-1662-1223964192-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkj0Nh0ACgkQ7b8eESbyJLh1awCgyBShA/zT/lTOGz29GNdbuClc
0psAoNTMBZCSaD0Vj/pUsncLfK+ynGuR
=poDq
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-1662-1223964192-0001-2--
