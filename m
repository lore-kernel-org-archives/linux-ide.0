From: Erik Slagter <erik@slagter.name>
Subject: Re: UDMA modes
Date: Tue, 16 Aug 2005 17:35:44 +0200
Message-ID: <1124206544.19419.4.camel@localhost.localdomain>
References: <42D7AAB8000479BA@mail-4.mail.tiscali.sys>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qEFYTPPIJg/SoAXb3N5Z"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oldconomy.demon.nl ([212.238.217.56]:1677 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1030182AbVHPPgG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 11:36:06 -0400
In-Reply-To: <42D7AAB8000479BA@mail-4.mail.tiscali.sys>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sampei02@tiscali.it
Cc: linux-ide@vger.kernel.org


--=-qEFYTPPIJg/SoAXb3N5Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-08-16 at 16:21 +0200, sampei02@tiscali.it wrote:
> My Maxtor Hard Disk supports UDMA <=3D 6 (133)
> How can I control BITS options in controller ? What's line command ?
> How can I verify controller is properly configured in my kernel ?

cd /usr/src/linux
make menuconfig
device drivers -> ATA/ATAPI/MFM/RLL support -> IGNORE word93 Validation
BITS

If you're using a kernel from your distribution, I am afraid it will
invalidate a lot of the options to get this working right.

--=-qEFYTPPIJg/SoAXb3N5Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDAgfQJgD/6j32wUYRAgzPAJ43M8Wwxf+ynHot/cXEH0sgTLHwKQCfZVdb
ELC8Q+B+dKX8dwPioWujGzo=
=Pwaw
-----END PGP SIGNATURE-----

--=-qEFYTPPIJg/SoAXb3N5Z--
