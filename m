From: Scott James Remnant <scott@ubuntu.com>
Subject: Re: regarding crazy head unloads
Date: Mon, 02 Jun 2008 10:55:54 +0100
Message-ID: <1212400554.16559.33.camel@wing-commander>
References: <48361F88.7040400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kmwtF/OEZn0d3rdCBucL"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bioshock.netsplit.com ([89.16.172.233]:4031 "EHLO
	bioshock.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757079AbYFBKoS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jun 2008 06:44:18 -0400
In-Reply-To: <48361F88.7040400@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bruce Allen <ballen@gravity.phys.uwm.edu>, roland.kletzing@materna.de, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>


--=-kmwtF/OEZn0d3rdCBucL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-05-23 at 10:36 +0900, Tejun Heo wrote:

> Attached are storage-fixup script which is to be called during boot and=20
> resume and configuration file to go under /etc.  The script can match=20
> dmi and hal properties and execute commands on the matching devices.=20
> The config file currently only contains three rules.
>=20
Could this not be done better inside HAL itself?

Scott
--=20
Scott James Remnant
scott@ubuntu.com

--=-kmwtF/OEZn0d3rdCBucL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIQ8OqSnQiFMl4yK4RAu8xAKCTTIdaCJOZX5N2B/pTkeLXnjIogACfbPlD
rgjWy4KdbjhfJBQu1JVYCJw=
=6Qf0
-----END PGP SIGNATURE-----

--=-kmwtF/OEZn0d3rdCBucL--

