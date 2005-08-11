From: Erik Slagter <erik@slagter.name>
Subject: Re: libata and PATA devices
Date: Thu, 11 Aug 2005 21:38:52 +0200
Message-ID: <1123789132.4422.30.camel@localhost.localdomain>
References: <200508071949.03782.inform@tiker.net>
	 <42F6B8CD.4050100@gmail.com>  <20050808030239.GA27502@havoc.gtf.org>
	 <1123495856.22328.62.camel@localhost.localdomain> <42F8B41C.4040408@rtr.ca>
	 <42FACCA8.6050408@pobox.com> <42FB853E.4070100@rtr.ca>
	 <42FB889F.50607@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3e3uqWQwdZzQAS/TbLaj"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:37603 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932385AbVHKTjE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 15:39:04 -0400
In-Reply-To: <42FB889F.50607@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org


--=-3e3uqWQwdZzQAS/TbLaj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-11 at 13:19 -0400, Jeff Garzik wrote:
> Mark Lord wrote:
> > Jeff Garzik wrote:
> >> currently no one should be using libata for PATA support.
> > We emailed back and forth extensively about how this has
> > not been true since early this year.  Modern laptops are
> > using libata for the ICH6M support, simply because libata
> > claims that chipset, and the IDE driver does not.
> > These laptops are using PATA drives (eg. "FUJITSU MHV2100AH").
>=20
> This sounds like a misconfigured kernel.  The IDE driver should pick up=20
> the PATA port, and libata should pick up the SATA port.  Anything else=20
> is a bug, and should be addressed by me or Bart.

See my and Marks posts now and two times in the past.

My PATA harddisk connected to ICH6M is NOT claimed by IDE but by libata
indeed.

If you think that is an error, that is okay with me, but it rather
puzzles me that when I post the patch that actually accomplishes this, I
only get a barking intel engineer and no other reply whatsoever.

BTW we're still talking plain vanilla kernel here.

So, please, make up your mind and at least don't simply deny or ignore
the situation.

> > And Passthru is much bigger than a pair of #defines.
> That is a separate $thread.

Also note that without passthrough libata is not half as useful as it
could be (no smart monitoring, ouch..)

> > Push some of this stuff out to the -mm tree, and maybe we'll get
> > more people exercising the code, and it'll progress more quickly.
>=20
> Both passthru and ATAPI code are already available in the -mm tree,=20
> unless Andrew made a mistake and accidentally dropped passthru.

Indeed I saw the passthrough code pass, but I don't remember having seen
any atapi patches.

--=-3e3uqWQwdZzQAS/TbLaj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBC+6lMJgD/6j32wUYRAo24AJ9q81In+NMM8P51CPGmsdC6/jYuEACffl8I
L97u42350hGfMdgd2f1RcN8=
=vUMk
-----END PGP SIGNATURE-----

--=-3e3uqWQwdZzQAS/TbLaj--
