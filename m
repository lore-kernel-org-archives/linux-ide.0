From: Martin Hicks <mort@bork.org>
Subject: sata_vsc and device hotplug
Date: Thu, 29 Jun 2006 10:49:56 -0400
Message-ID: <20060629144956.GF16658@bork.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:35790 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1750750AbWF2Ot4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2006 10:49:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id 491E2404C
	for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 10:49:56 -0400 (EDT)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22896-07 for <linux-ide@vger.kernel.org>;
	Thu, 29 Jun 2006 10:49:56 -0400 (EDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


So I've verified that device warmplug works correctly with the latest
libata-dev#master tree.  What, conceptually, has to happen to the
sata_vsc driver to get it to support hotplug.

Is it a case of getting the PHY state change interrupt to alert us when
something comes alive on one of the ports?

thanks
mh

--=20
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEo+iT0ZUZrUx/K+4RArxDAJ9UiiKX+uW35kOvCPQ+TMu7XC1VBwCgzLl5
diA6HRWuUU2u7R2DnvSOVjY=
=PMb+
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
