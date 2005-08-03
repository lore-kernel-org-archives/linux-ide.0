From: Adam Goode <adam@evdebs.org>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 03 Aug 2005 14:12:41 -0400
Message-ID: <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu>
References: <42EF93F8.8050601@fujitsu-siemens.com>
	 <20050802163519.GB3710@suse.de>  <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T2iqRVyEcl4pLSqTu15z"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server262.com ([64.14.68.15]:38356 "EHLO server262.com")
	by vger.kernel.org with ESMTP id S262381AbVHCSNI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 14:13:08 -0400
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>


--=-T2iqRVyEcl4pLSqTu15z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-08-03 at 07:17 +0200, Martin Wilck wrote:
> Jens Axboe wrote:
>=20
> >>If I am reading the specs correctly, that'd mean the ahci driver is=20
> >>wrong in setting the SActive bit.
> >=20
> > I completely agree, that was my reading of the spec as well and hence m=
y
> > original posts about this in the NCQ thread.
>=20
> Have you (or has anybody else) also seen the wrong behavior of the=20
> activity LED?

Yes, Dell Precision 380, ICH7R AHCI controller, SATA non-NCQ Western
Digital drive.


Adam


--=-T2iqRVyEcl4pLSqTu15z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8QkZlenB4PQRJawRAk3kAJ4yui1ZC8oophTsbDAnUnG0/0kAcgCgghud
JV+sKoa/yL4Ex5EPdQwi4qU=
=ufbG
-----END PGP SIGNATURE-----

--=-T2iqRVyEcl4pLSqTu15z--

